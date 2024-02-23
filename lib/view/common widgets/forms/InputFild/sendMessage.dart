import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SendMessage extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  const SendMessage(
      {super.key,
      required this.size,
      required this.controller,
      required this.hint,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: size.width,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: TextFormField(
        obscureText: obscureText,
        cursorColor: Colors.black,
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            suffix: const Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                size: 17,
                Icons.send,
                color: Colors.blue,
              ), // icon is 48px widget.
            ),
            contentPadding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                bottom: size.width * 0.03),
            hintText: hint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusColor: Colors.black),
      ),
      // Search(controller: message, hint: 'type your message here', obscureText: false, size: size,)
    );
  }
}
