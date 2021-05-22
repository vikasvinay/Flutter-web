import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OrderTracking {
  String message;
  String processState;
  String status;
  bool isprocessStateDone;

  OrderTracking(
      {this.message, this.processState, this.status, this.isprocessStateDone});
      
  OrderTracking.fromFireStore({@required Map<String, dynamic> map}) {
    this.message = map['message'];
    this.processState = map['processState'];
    this.status = map['status'];
    this.isprocessStateDone = map['isprocessStateDone'];
  }

  factory OrderTracking.byId({@required DocumentSnapshot doc}) {
    return OrderTracking(
        message: doc['message'],
        processState: doc['processState'],
        status: doc['status'],
        isprocessStateDone: doc['isprocessStateDone']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['message'] = message;
    map['processState'] = processState;
    map['isprocessStateDone'] = isprocessStateDone;
    return map;
  }
}
