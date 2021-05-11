import 'dart:async';
import 'dart:math';

import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @observable
  bool loggedOut = false;

  @observable
  bool error = false;

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
      loading = false;
      loggedIn = true;
    }
  }

  @action
  Future<void> logout() async {
    await _auth.signOut();
    loggedOut = true;
  }
}

// abstract class _Auth with Store {
//   @observable
//   String homePage = _auth.currentUser ?? RouteNames.login;

//   @action
//   Future loginWithEmail({String email, String password}) async {
//     await _auth
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       if (value.additionalUserInfo.providerId != null) {
//         homePage = RouteNames.home;
//       }
//     });
//   }

//   ///logout
//   @action
//   Future logout() async {
//     return await _auth.signOut();
//   }
// }

// abstract class _Auth with Store {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   @observable
//   String page = RouteNames.login;

//   @action
//   Future loginWithEmail({String email, String password}) async {
//     try {
//       print("in login");
//       await _auth
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((value) {
//         if (_auth.currentUser.uid != null) {
//           print(_auth.currentUser.uid);
//           return page = RouteNames.home;
//         }
//       });

//       print(_auth.currentUser.uid);

//       return page;
//     } catch (e) {
//       print("got exit");
//       print(e);
//       return e;

//     }
//   }

//   Future logout() async {
//     return await _auth.signOut();
//   }
  
// }
