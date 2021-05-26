import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/order_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class OrderRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  OrderRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = FirebaseFirestore.instance;

  Stream<OrderedUsers> orderedUser({@required productId, @required userId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> data = firebaseFirestore
        .collection('admin_products')
        .doc(productId)
        .collection('ordered_users')
        .doc(userId)
        .snapshots();
    return data.asyncMap((event) {
      print("000000000${event.id}");
      return OrderedUsers.byId(doc: event);
    });
  }
}
