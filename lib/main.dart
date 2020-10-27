import 'package:article_firebase/screen1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.grey),
            textTheme: TextTheme(
               headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
              subtitle1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
              subtitle2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              caption: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),

            )
        ),
        home: Home(),
      )
  );
}

