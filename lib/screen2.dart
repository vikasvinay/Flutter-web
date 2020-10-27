import 'package:article_firebase/screen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFire extends StatefulWidget {
  @override
  _GetFireState createState() => _GetFireState();
}
///getting data from firestore
fetchData() async {
  var firestore = FirebaseFirestore.instance;
  QuerySnapshot qs = await firestore.collection('Articles').get();
  return qs.docs;
}

class _GetFireState extends State<GetFire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
              child: Text(
            'Articles',
            style: Theme.of(context).textTheme.headline1,
          )),
          FutureBuilder(
              future: fetchData(),
              builder: (_, snapshort) {
                if (snapshort.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Text('Loading...',
                          style: Theme.of(context).textTheme.headline1));
                } else {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, index) => Padding(
                        padding: const EdgeInsets.only(left: 80, right: 20),
                        child: Divider(
                          height: 10,
                          thickness: 2,
                        ),
                      ),
                      shrinkWrap: true,
                      itemCount: snapshort.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          leading: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                  NetworkImage(snapshort.data[index]['Url']),
                                )),
                          ),
                          title: Text(snapshort.data[index]['Title'],
                              style: Theme.of(context).textTheme.subtitle2),
                          subtitle: Text(
                            snapshort.data[index]['Description'],
                            style: Theme.of(context).textTheme.caption,
                          ),
                          // trailing: Text(time),
                        );
                      },
                    ),
                  );
                }
              }),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
