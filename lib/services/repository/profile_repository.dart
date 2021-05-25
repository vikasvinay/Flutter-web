import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ProfileRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = FirebaseFirestore.instance;


}