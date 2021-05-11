// import 'package:ecommerce_admin/services/login_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';

// class Counter extends StatelessWidget {
//   final Auth store = Auth();
//   @override
//   Widget build(BuildContext context) => Scaffold(

//       appBar: AppBar(
//         title: const Text('Random Number Generator'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Random number',
//               style: TextStyle(color: Colors.grey),
//             ),
//             Observer(
//               builder: (_) {
//                 final value = store.randomStream.value;

//                 return Text(
//                   '${value == null ? '---' : value}',
//                   style: TextStyle(fontSize: 96),
//                 );
//               },
//             ),
//           ],
//         ),
//       ));

//   @override
//   void dispose() {
//     store.dispose();
//   }
// }
