import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

class Profile {
  String uid;
  String companyName;

  Profile({this.companyName, this.uid});

  factory Profile.getById({@required DocumentSnapshot doc}) {
    return Profile(companyName: doc.get('company_name'), uid: doc.get('uid'));
  }
}
