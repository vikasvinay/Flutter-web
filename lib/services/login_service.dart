import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'login_service.g.dart';

class Auth = _Auth with _$Auth;
FirebaseAuth _auth = FirebaseAuth.instance;

abstract class _Auth with Store {
  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool noAccess = false;

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @observable
  bool loggedOut = false;

  @observable
  bool error = false;

  @observable
  String  pageState =
      _auth.currentUser != null ? RouteNames.home : RouteNames.login;

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => (password.length >= 6);

  @computed
  Function get loginPressed => (isEmailValid) ? login : null;

  @computed
  Function get logoutPressed => (_auth.currentUser != null) ? logout : logout;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setPasswordVisible() => passwordVisible = !passwordVisible;

  @action
  Future<void> login() async {
    loading = true;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      loading = false;
      loggedIn = false;
      error = true;
      return e;
    }

    if (_auth.currentUser != null) {
      print(_auth.currentUser.uid);
      DocumentSnapshot<Map<String, dynamic>> userAccess =
          await FirebaseFirestore.instance
              .collection('admin_products_access')
              .doc(_auth.currentUser.uid)
              .get();
      if (!userAccess.exists ||
          !userAccess.data().containsKey('access') ||
          !await userAccess['access']) {
        print(" no account");
        await logout();
        loading = false;
        noAccess = true;
      } else {
        print("has account");
        loggedIn = true;
        loading = false;
      }
    }
  }

  @action
  Future<void> logout() async {
    await _auth.signOut();
    loggedOut = true;
  }
}
