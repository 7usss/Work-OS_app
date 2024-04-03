import 'package:flutter/material.dart';

class LargBotton extends StatelessWidget {
  const LargBotton({super.key, required this.text, required this.colors});
  final String text;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36),
      alignment: Alignment.center,
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: colors)),
      child: const Text(
        'Log Out',
        style: TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}
