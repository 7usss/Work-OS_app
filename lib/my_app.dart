import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project4/pages/company_use_pager.dart';
import 'package:project4/pages/home_page.dart';
import 'package:project4/pages/login_page.dart';
import 'package:project4/pages/profile_page.dart';
import 'package:project4/pages/register_page.dart';
import 'package:project4/pages/task_details_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
