// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Auth on _Auth, Store {
  Computed<bool> _$isEmailValidComputed;

  @override
  bool get isEmailValid => (_$isEmailValidComputed =
          Computed<bool>(() => super.isEmailValid, name: '_Auth.isEmailValid'))
      .value;
  Computed<bool> _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed = Computed<bool>(() => super.isPasswordValid,
              name: '_Auth.isPasswordValid'))
          .value;
  Computed<Function> _$loginPressedComputed;

  @override
  Function get loginPressed =>
      (_$loginPressedComputed = Computed<Function>(() => super.loginPressed,
              name: '_Auth.loginPressed'))
          .value;
  Computed<Function> _$logoutPressedComputed;

  @override
  Function get logoutPressed =>
      (_$logoutPressedComputed = Computed<Function>(() => super.logoutPressed,
              name: '_Auth.logoutPressed'))
          .value;

  final _$emailAtom = Atom(name: '_Auth.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_Auth.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$passwordVisibleAtom = Atom(name: '_Auth.passwordVisible');

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  final _$loadingAtom = Atom(name: '_Auth.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$loggedInAtom = Atom(name: '_Auth.loggedIn');

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  final _$loggedOutAtom = Atom(name: '_Auth.loggedOut');

  @override
  bool get loggedOut {
    _$loggedOutAtom.reportRead();
    return super.loggedOut;
  }

  @override
  set loggedOut(bool value) {
    _$loggedOutAtom.reportWrite(value, super.loggedOut, () {
      super.loggedOut = value;
    });
  }

  final _$errorAtom = Atom(name: '_Auth.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_Auth.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$logoutAsyncAction = AsyncAction('_Auth.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_AuthActionController = ActionController(name: '_Auth');

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_AuthActionController.startAction(name: '_Auth.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo =
        _$_AuthActionController.startAction(name: '_Auth.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordVisible() {
    final _$actionInfo =
        _$_AuthActionController.startAction(name: '_Auth.setPasswordVisible');
    try {
      return super.setPasswordVisible();
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
passwordVisible: ${passwordVisible},
loading: ${loading},
loggedIn: ${loggedIn},
loggedOut: ${loggedOut},
error: ${error},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid},
loginPressed: ${loginPressed},
logoutPressed: ${logoutPressed}
    ''';
  }
}
