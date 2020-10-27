import 'package:flutter/material.dart';

///field for user interaction
field(BuildContext context, String hintText, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.all(10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.subtitle1),
    ),
  );
}
