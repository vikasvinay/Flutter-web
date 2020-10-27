import 'package:article_firebase/class.dart';
import 'package:article_firebase/screen2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
///text fields data
TextEditingController _titleController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _ulrController = TextEditingController();

///initialize firestore
CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('Articles');
Map<String, dynamic> typedData;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
///adding map function to typed text
    sendToCloud() async {
      typedData = {
        "Title": _titleController.text,
        "Description": _descriptionController.text,
        "Url": _ulrController.text,
      };

      ///sending data to fireStore
      if (typedData["Url"].isNotEmpty) {
        await _collectionReference.add(typedData).whenComplete(() =>
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => GetFire())));
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Article",
            style: Theme.of(context).textTheme.headline1,
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GetFire())); //Articles()));
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 30),
            field(context, 'Title', _titleController),
            SizedBox(height: 10),
            field(context, 'Description', _descriptionController),
            SizedBox(height: 10),
            field(context, 'Image Url', _ulrController),
            SizedBox(height: 5,),
            Text("Note: Please fill the fields."),
            SizedBox(height: 70),
            GestureDetector(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)))),
                onTap: () {
                  sendToCloud();
                })
          ],
        )));
  }
}
