import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllText {
  static Widget Autotext(
      {required String text,
      required double fontSize,
      required fontWeight,
      required color}) {
    return AutoSizeText(
      textAlign: TextAlign.center,
      text,
      style: GoogleFonts.rubik(
        textStyle:
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
