import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ProfileRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = FirebaseFirestore.instance;

  Stream<KarmaUser> getProfileById({@required String profileId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> userData =
        firebaseFirestore.collection('users').doc(profileId).snapshots();

    return userData
        .asyncMap((event) => KarmaUser.fromFirestore(map: event.data()));
  }
}
