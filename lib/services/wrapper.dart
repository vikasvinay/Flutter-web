import 'dart:async';
import 'dart:math';

import 'package:ecommerce_admin/services/login_service.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// class Wrapper extends StatefulWidget {
//   @override
//   _WrapperState createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   Auth _auth = Auth();

//   @override
//   Widget build(BuildContext context) {
//     return Observer(
//       builder: (_){
//         Navigator.pushNamed(context, _auth.path);//_auth.hpmePage
//         return Container();
//       },
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _auth = Provider.of<Auth>(context);
//   }
// }

// part 'random_store.g.dart';

// class RandomStore = _RandomStore with _$RandomStore;

// abstract class _RandomStore with Store {
//   final Timer _timer;

//   final _random = Random();

//    final StreamController<int> _streamController;

//    final ObservableStream<int> randomStream;
//   _RandomStore() {
//     _streamController = StreamController<int>();

//     _timer = Timer.periodic(const Duration(seconds: 1),
//         (_) => _streamController.add(_random.nextInt(100)));

//     randomStream = ObservableStream(_streamController.stream);
//   }

   

//   // ignore: avoid_void_async
//   void dispose() async {
//     _timer.cancel();
//     await _streamController.close();
//   }
// }
