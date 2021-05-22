import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/order_tracking.dart';
import 'package:flutter/foundation.dart';

class OrderedUsers {
  String address;
  String receiverName;
  String productStatus;
  int phoneNumber;
  String userId;
  OrderTracking orderTracking;
  OrderedUsers(
      {this.address,
      this.receiverName,
      this.productStatus,
      this.phoneNumber,
      this.orderTracking,
      this.userId});

  OrderedUsers.fromFireStore(
      {@required Map<String, dynamic> map, @required String id}) {
    this.address = map['address'];
    this.phoneNumber = map['phone_number'];
    this.productStatus = map['product_status'];
    this.userId = id;
    this.receiverName = map['receiver_name'];
    this.orderTracking = map['tracking_details'];
  }
  factory OrderedUsers.byId({@required DocumentSnapshot doc}) {
    return OrderedUsers(
        address: doc['address'],
        productStatus: doc['product_status'],
        userId: doc.id,
        // orderTracking: doc['tracking_details'],
        phoneNumber: doc['phone_number'],
        receiverName: doc['receiver_name']);
  }
}
