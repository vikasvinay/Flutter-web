import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/message_model.dart';
import 'package:ecommerce_admin/services/models/order_users.dart';
import 'package:ecommerce_admin/services/models/product_model.dart';
import 'package:ecommerce_admin/services/models/user.dart';
import 'package:ecommerce_admin/services/repository/orders_repository.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_admin/services/repository/admin_product_questions.dart';
import 'package:ecommerce_admin/services/repository/product_repository.dart';
import 'package:ecommerce_admin/services/repository/profile_repository.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  MessageRepository _messageRepository = MessageRepository();
  ProfileRepository _profileRepository = ProfileRepository();
  ProductRepository _productRepository = ProductRepository();
  OrderRepository _orderRepository = OrderRepository();
  MessageModel _messageModel = MessageModel();
  TextEditingController _editingController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Messages"),
        ),
        body: StreamBuilder<List<MessageModel>>(
            stream: _messageRepository.getAllMessage(),
            builder: (context, messageSnapshot) {
              if (!messageSnapshot.hasData ||
                  messageSnapshot.data.length <= 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(messageSnapshot.data.length);
              print("------------${messageSnapshot.data[0].productId}");
              return GridView.builder(
                  itemCount: messageSnapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return FutureBuilder<ProductModel>(
                        future: _productRepository.getaProduct(
                            productId: messageSnapshot.data[index].productId),
                        builder: (context, productSnapshot) {
                          return StreamBuilder<KarmaUser>(
                              stream: _profileRepository.getProfileById(
                                  profileId:
                                      messageSnapshot.data[index].userUid),
                              builder: (context, userSnapshot) {
                                print(messageSnapshot.data[index].userUid);

                                if (!userSnapshot.hasData ||
                                    userSnapshot.requireData == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                print(
                                    "###############${messageSnapshot.data[index].productId}");
                                print(
                                    "******************${messageSnapshot.data[index].userUid}");
                                return StreamBuilder<OrderedUsers>(
                                    stream: _orderRepository.orderedUser(
                                        productId: messageSnapshot
                                            .data[index].productId,
                                        userId: messageSnapshot
                                            .data[index].userUid),
                                    builder: (context, orderSnapshot) {
                                      if (!orderSnapshot.hasData ||
                                          orderSnapshot.requireData == null) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      print(orderSnapshot.data.address);
                                      return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: FittedBox(
                                            child: userCard(
                                                userId: messageSnapshot
                                                    .data[index].userUid,
                                                productId: messageSnapshot
                                                    .data[index].productId,
                                                productCategory: productSnapshot
                                                    .data.productCategory,
                                                userQuestion: messageSnapshot
                                                    .data[index].question,
                                                productName: productSnapshot
                                                    .data.productName,
                                                context: context,
                                                deliveryAddress:
                                                    orderSnapshot.data.address,
                                                hasAns: messageSnapshot
                                                    .data[index].hasAnswer,
                                                name: userSnapshot.data.name,
                                                receiverName: orderSnapshot
                                                    .data.receiverName,
                                                size: size,
                                                userUrl:
                                                    userSnapshot.data.photoUrl,
                                                producturl: productSnapshot
                                                    .data.imageUrl),
                                          ));
                                    });
                              });
                        });
                  });
            }));
  }

  Widget userCard(
      {@required String name,
      @required String userUrl,
      @required Size size,
      @required String productId,
      @required String userId,
      @required String userQuestion,
      @required String receiverName,
      @required String productName,
      @required String productCategory,
      @required bool hasAns,
      @required BuildContext context,
      @required String producturl,
      @required String deliveryAddress}) {
    return Material(
      elevation: 5,
      color: hasAns ? Colors.lightGreen[200] : Colors.amber,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        child: Container(
            height: size.height / 2,
            width: 0.5.sw,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      userUrl,
                      height: size.height / 8,
                      width: size.width / 8,
                    ),
                    Text("User name: $name",
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product name: $productName",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800)),
                      Text("Reciver name: $receiverName",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800)),
                      Text("Address: $deliveryAddress",
                          style: TextStyle(fontSize: 30))
                    ],
                  ),
                )
              ],
            )),
        onTap: () async {
          showBottomSheet(
              context: context,
              builder: (_) {
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
                        margin: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                FluroRoute.router.navigateTo(
                                    context, RouteNames.orderList,
                                    routeSettings:
                                        RouteSettings(arguments: productId));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    producturl,
                                    height: size.height / 8,
                                    width: size.width / 8,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Product name: $productName",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Product category: $productCategory",
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              children: [
                                Text("$userQuestion",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 40,
                                ),
                                Form(
                                  key: _key,
                                  child: Container(
                                    width: size.width / 10,
                                    child: TextFormField(
                                      validator: (value) {
                                        return value.length >= 3
                                            ? null
                                            : "Fill the field";
                                      },
                                      controller: _editingController,
                                      decoration:
                                          InputDecoration(hintText: 'answer'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              child: MaterialButton(
                                color: Colors.lightGreen,
                                focusColor: Colors.amber,
                                child: Text(hasAns? "Sent":"Send"),
                                onPressed: hasAns
                                    ? null
                                    : () async {
                                        if (_key.currentState.validate()) {
                                          _messageModel.answer =
                                              _editingController.text;
                                          _messageModel.hasAnswer = true;
                                          _messageModel.answerTimeStamp =
                                              DateTime.now()
                                                  .millisecondsSinceEpoch;
                                          await FirebaseFirestore.instance
                                              .collection(
                                                  'admin_products_access')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser.uid)
                                              .collection('product_questions')
                                              .doc(userId)
                                              .set(_messageModel.toMap(),
                                                  SetOptions(merge: true));
                                        }
                                      },
                              ),
                            )
                          ],
                        ),
                      )),
                );
              });
        },
      ),
    );
  }
}
