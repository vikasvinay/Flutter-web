import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages"),),
      body:StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Container();
        }
      )
      
    );
  }
}