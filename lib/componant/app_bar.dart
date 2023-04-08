import 'package:flutter/material.dart';
import 'package:project4/model/categorise_filter.dart';

class Appbar extends StatefulWidget {
  final String categoryfilter1;
  const Appbar({super.key, required this.categoryfilter1});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
      elevation: 0,
      backgroundColor: Colors.black.withOpacity(0.1),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_sharp,
              color: Colors.white,
            ))
      ],
      centerTitle: true,
      title: const Text(
        'Task Management',
        style: TextStyle(
          shadows: [
            BoxShadow(offset: Offset(0, 5), color: Color.fromARGB(47, 151, 226, 247), spreadRadius: 1, blurRadius: 7)
          ],
          fontFamily: 'JosefinSans',
          color: Color(0xff386063),
          fontSize: 26,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
