import 'package:flutter/material.dart';

Widget MakeInput({
  required label,
  obsureText = false,
  bool? isNumber,
  TextEditingController? controller,
  required Null Function(dynamic v) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        onChanged: (v) {
          onChanged(v);
        },
        controller: controller,
        obscureText: obsureText,
        keyboardType: isNumber == true ? TextInputType.number : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400]!,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!)),
        ),
      ),
      SizedBox(
        height: 30,
      )
    ],
  );
}
