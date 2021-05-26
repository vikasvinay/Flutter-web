import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MessageRepository {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;

  MessageRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<MessageModel>> getAllMessage() {
    List<MessageModel> list = [];
    Stream<QuerySnapshot<Map<String, dynamic>>> data = firebaseFirestore
        .collection('admin_products_access')
        .doc(firebaseAuth.currentUser.uid)
        .collection('product_questions')
        .snapshots();

    return data.asyncMap((event) {
      for (int i = 0; i < event.size; i++) {
        list.add(MessageModel.fromFireStore(
            map: event.docs[i].data(), userUid: event.docs[i].id));
      }
      return list;
    });
  }
}
