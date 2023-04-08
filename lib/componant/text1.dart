import 'package:flutter/material.dart';

class Text1 extends StatelessWidget {
  const Text1(
      {super.key,
      required this.text,
      required this.fontsized1,
      this.color = Colors.black,
      this.fontweights = FontWeight.w500});

  final String text;
  final double fontsized1;
  final Color color;
  final FontWeight fontweights;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontsized1, fontWeight: fontweights),
    );
  }
}
