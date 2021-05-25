// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  Computed<String> _$companyNameComputed;

  @override
  String get companyName =>
      (_$companyNameComputed ??= Computed<String>(() => super.companyName,
              name: '_HomeController.companyName'))
          .value;
  Computed<String> _$uidComputed;

  @override
  String get uid => (_$uidComputed ??=
          Computed<String>(() => super.uid, name: '_HomeController.uid'))
      .value;

  final _$_uidAtom = Atom(name: '_HomeController._uid');

  @override
  String get _uid {
    _$_uidAtom.reportRead();
    return super._uid;
  }

  @override
  set _uid(String value) {
    _$_uidAtom.reportWrite(value, super._uid, () {
      super._uid = value;
    });
  }

  final _$_companyNameAtom = Atom(name: '_HomeController._companyName');

  @override
  String get _companyName {
    _$_companyNameAtom.reportRead();
    return super._companyName;
  }

  @override
  set _companyName(String value) {
    _$_companyNameAtom.reportWrite(value, super._companyName, () {
      super._companyName = value;
    });
  }

  final _$getProfileAsyncAction = AsyncAction('_HomeController.getProfile');

  @override
  Future<void> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  @override
  String toString() {
    return '''
companyName: ${companyName},
uid: ${uid}
    ''';
  }
}
