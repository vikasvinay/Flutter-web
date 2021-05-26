import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OrderedUsers {
  String address;
  String receiverName;
  String productStatus;
  int phoneNumber;
  String userId;
  OrderedUsers(
      {this.address,
      this.receiverName,
      this.productStatus,
      this.phoneNumber,
      this.userId});

  OrderedUsers.fromFireStore(
      {@required Map<String, dynamic> map, @required String id}) {
    print(map);
    this.address = map['address'];
    this.phoneNumber = map['phone_number'];
    this.productStatus = map['product_status'];
    this.userId = id;
    this.receiverName = map['receiver_name'];
  }
  factory OrderedUsers.byId({@required DocumentSnapshot doc}) {
    return OrderedUsers(
        address: doc['address'],
        productStatus: doc['product_status'],
        userId: doc.id,
        phoneNumber: doc['phone_number'],
        receiverName: doc['receiver_name']);
  }
}
