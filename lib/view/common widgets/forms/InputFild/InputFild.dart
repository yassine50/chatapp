import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Search extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  const Search(
      {super.key,
      required this.size,
      required this.controller,
      required this.hint,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: size.width*0.35,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: Color(0xFF948B8B))),
      child: TextFormField(
        obscureText: obscureText,
        cursorColor: Colors.black,
        controller: controller,
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: size.width * 0.03, right: size.width * 0.03,bottom:size.width * 0.03 ),
            hintText: hint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusColor: Colors.black),
      ),
    );
  }
}