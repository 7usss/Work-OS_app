import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
      height: 40,
      width: 200,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 242, 245, 245),
          fontFamily: 'JosefinSans',
        ),
      ),
    );
  }
}
