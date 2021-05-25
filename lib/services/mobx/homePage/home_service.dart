import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';
part 'home_service.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  // Profile _profile = Profile();
  @observable
  String _uid = '';

  @observable
  String _companyName = '';

  @computed
  String get companyName => _companyName;

  @computed
  String get uid => _uid;

  @action
  Future<void> getProfile() async {
    DocumentSnapshot profile = await FirebaseFirestore.instance
        .collection('admin_products_access')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    _companyName = await profile.get('company_name');
    _uid = await profile.get('uid');
  }
}
