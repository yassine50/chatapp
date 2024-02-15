import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../text/text.dart';

class BlueButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double width ; 
  final bool outlindedbutton ; 
  const BlueButton({super.key, required this.onTap, required this.text,required this.width, required  this.outlindedbutton });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 24),
        height: 48,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
              border: outlindedbutton?Border.all(width: 0, color: Color(0xFF3053EC)) : Border.all(width: 1, color: Color(0xFF3053EC)),
          color:   outlindedbutton ? Colors.white : Color(0xFF3053EC),
          borderRadius: BorderRadius.circular(48),
        ),
        child: AllText.Autotext(
          color:outlindedbutton ?Color(0xFF3053EC) : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          text: text,
        ),
      ),
    );
  }
}
