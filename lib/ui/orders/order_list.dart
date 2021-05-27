import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/order_tracking.dart';
import 'package:ecommerce_admin/services/models/order_users.dart';
import 'package:ecommerce_admin/services/models/user.dart';
import 'package:ecommerce_admin/services/palette.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersList extends StatefulWidget {
  final String productId;

  OrdersList({Key key, @required this.productId}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

enum Status { Processing, Delivered }

class _OrdersListState extends State<OrdersList> {
  // TextEditingController _textEditingController1 = TextEditingController();
  OrderTracking _orderTracking = OrderTracking();
  var stateList = <String>[
    "Order Placed",
    "Order Confirmed",
    "Order Processed",
    "Ready to Ship",
    "Out to Delivery"
  ];

  List<TextEditingController> _controller =
      List.generate(5, (index) => TextEditingController());
  Status _status = Status.Processing;
  String setStatus = 'PROCESSING';
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders list"),
      ),
      body: PaginateFirestore(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        shrinkWrap: true,
        isLive: true,
        onError: (_) {
          return Text("$_");
        },
        query: FirebaseFirestore.instance
            .collection('admin_products')
            .doc(widget.productId)
            .collection('ordered_users'),
        itemBuilderType: PaginateBuilderType.gridView,
        itemBuilder: (int index, BuildContext context, DocumentSnapshot snap) {
          if (!snap.exists) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          /// snap has  address
          print("address-------------${snap.data()}");
          OrderedUsers deliveryAddress =
              OrderedUsers.fromFireStore(map: snap.data(), id: snap.id);
          print(deliveryAddress.phoneNumber);
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snap.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.requireData == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                KarmaUser users =
                    KarmaUser.fromFirestore(map: snapshot.data.data());
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FittedBox(
                    child: userCard(
                        context: context,
                        userId: snap.id,
                        imageUrl: users.photoUrl,
                        name: users.name,
                        receiverName: deliveryAddress.receiverName,
                        status: deliveryAddress.productStatus,
                        phoneNumber: deliveryAddress.phoneNumber,
                        deliveryAddress: deliveryAddress.address,
                        size: size),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget userCard(
      {String name,
      String imageUrl,
      int phoneNumber,
      Size size,
      String userId,
      String receiverName,
      String status,
      BuildContext context,
      String deliveryAddress}) {
    return Material(
      elevation: 5,
      color: status == 'DELIVERED' ? Colors.lightGreen[200] : Colors.amber,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        child: Container(
            height: size.height / 2,
            width: 0.5.sw,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  imageUrl,
                  height: size.height / 10,
                  width: size.width / 10,
                ),
                Text("User name: $name",
                    style:
                        TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
                Text("Reciver name: $receiverName",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                Text(
                  "Status: $status",
                  style: TextStyle(fontSize: 30),
                ),
                Text("Phone number: $phoneNumber",
                    style: TextStyle(fontSize: 30)),
                Text("Address: $deliveryAddress",
                    style: TextStyle(fontSize: 30))
              ],
            )),
        onTap: () async {
          showBottomSheet(
              context: context,
              builder: (_) {
                List<bool> listOfBool = List.generate(5, (index) => false);
                return AnimateIfVisibleWrapper(
                  delay: Duration(seconds: 2),
                  child: Material(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.grey[350],
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height / 2,
                      width: size.width / 0.5,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        Widget tracking(
                            {String trackerState,
                            bool isTrue,
                            TextEditingController controller,
                            int index,
                            Size size}) {
                          return Column(
                            children: [
                              Text(trackerState,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              Checkbox(
                                  value: isTrue,
                                  onChanged: (value) {
                                    print("on set state----$isTrue");
                                    setState(() {
                                      listOfBool[index] = !listOfBool[index];
                                    });
                                    print(
                                        "!!!!-----$index======!!!!!${listOfBool[index]}");
                                  }),
                              Container(
                                width: size.width / 8,
                                height: size.height / 10,
                                child: TextFormField(
                                  controller: controller,
                                  maxLines: 4,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Message for user",
                                  ),
                                ),
                              )
                            ],
                          );
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  imageUrl,
                                  height: size.height / 10,
                                  width: size.width / 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text("Receiver name: $receiverName",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800)),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Status: $status",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('admin_products')
                                    .doc(widget.productId)
                                    .collection('ordered_users')
                                    .doc(userId)
                                    .collection('tracking_details')
                                    .doc('tracking')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.requireData.exists ||
                                      snapshot.requireData.data().length <= 0 ||
                                      snapshot.hasError) {
                                    return Center(
                                      child: Text("ERROR"),
                                    );
                                  }
                                  if (snapshot.requireData.data()['details'] ==
                                      null) {
                                    return Container(
                                      height: size.height / 6,
                                      margin: EdgeInsets.only(
                                          left: size.width / 10),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listOfBool.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  tracking(
                                                      controller:
                                                          _controller[index],
                                                      isTrue: listOfBool[index],
                                                      size: size,
                                                      index: index,
                                                      trackerState:
                                                          stateList[index]),
                                                  if (index != 4)
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      size: 30,
                                                      color: Palette.darkGreen,
                                                    )
                                                ],
                                              ),
                                            );
                                          }),
                                    );
                                  }
                                  return Container(
                                    height: size.height / 6,
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(left: size.width / 10),
                                    child: Row(
                                      children: [
                                        ...List.generate(listOfBool.length,
                                            (index) {
                                          OrderTracking orderTrackingState =
                                              OrderTracking.fromFireStore(
                                                  map: snapshot.requireData
                                                          .data()['details']
                                                      [index]);
                                          if (temp == 0) {
                                            for (int i = 0; i <= 4; i++) {
                                              listOfBool[i] = snapshot
                                                      .requireData
                                                      .data()['details'][i]
                                                  ['isprocessStateDone'];
                                            }
                                            temp = 1;
                                          }

                                          return Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                tracking(
                                                    controller:
                                                        _controller[index]
                                                          ..text =
                                                              orderTrackingState
                                                                  .message,
                                                    isTrue: listOfBool[index],
                                                    size: size,
                                                    index: index,
                                                    trackerState:
                                                        orderTrackingState
                                                            .processState),
                                                if (index != 4)
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    size: 30,
                                                    color: Palette.darkGreen,
                                                  )
                                              ],
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  );
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: size.width / 5,
                                  child: ListTile(
                                    leading: Radio<Status>(
                                        value: Status.Processing,
                                        groupValue: _status,
                                        onChanged: (Status value) {
                                          setState(() {
                                            _status = value;
                                            setStatus = 'PROCESSING';
                                          });
                                        }),
                                    title: Text("PROCESSING"),
                                  ),
                                ),
                                Container(
                                  width: size.width / 5,
                                  child: ListTile(
                                    leading: Radio<Status>(
                                        value: Status.Delivered,
                                        groupValue: _status,
                                        onChanged: (Status value) {
                                          setState(() {
                                            _status = value;
                                            setStatus = 'DELIVERED';
                                          });
                                        }),
                                    title: Text("DELIVERED"),
                                  ),
                                )
                              ],
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              child: MaterialButton(
                                color: Palette.darkGreen,
                                disabledColor: Colors.red,
                                onPressed: status == 'DELIVERED'
                                    ? null
                                    : () async {
                                        var send = [];
                                        temp = 0;
                                        for (int i = 0;
                                            i < stateList.length;
                                            i++) {
                                          _orderTracking.isprocessStateDone =
                                              listOfBool[i];
                                          _orderTracking.message =
                                              _controller[i].text;
                                          _orderTracking.processState =
                                              stateList[i];
                                          _orderTracking.status =
                                              setStatus == 'PROCESSING'
                                                  ? 'PROCESSING'
                                                  : 'DELIVERED';
                                          _orderTracking.toMap();
                                          send.add(_orderTracking.toMap());
                                        }
                                        await FirebaseFirestore.instance
                                            .collection('admin_products')
                                            .doc(widget.productId)
                                            .collection('ordered_users')
                                            .doc(userId)
                                            .collection('tracking_details')
                                            .doc('tracking')
                                            .set({
                                          'details': send
                                        }, SetOptions(merge: true)).then(
                                                (value) =>
                                                    Navigator.pop(context));
                                        if (_orderTracking.status ==
                                            'DELIVERED') {
                                          await FirebaseFirestore.instance
                                              .collection('admin_products')
                                              .doc(widget.productId)
                                              .collection('ordered_users')
                                              .doc(userId)
                                              .set({
                                            'product_status': 'DELIVERED'
                                          }, SetOptions(merge: true));
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userId)
                                              .collection('earthy_products')
                                              .doc(widget.productId)
                                              .set({
                                            'product_status': 'DELIVERED'
                                          }, SetOptions(merge: true));
                                        }
                                      },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
