import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: size.height / 20,
            child: Column(
              children: [
                Text(
                  "404!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Text(
                  "Reload page",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
