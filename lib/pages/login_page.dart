import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project4/pages/home_page.dart';

import 'package:project4/pages/register_page.dart';

import '../componant/text_field1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emaillogin = TextEditingController();
  final passlogin = TextEditingController();
  String? _uid;
  String? user_email;
  final bool _isFocused = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Task Management',
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Color.fromARGB(47, 151, 226, 247),
                          spreadRadius: 1,
                          blurRadius: 7)
                    ],
                    fontFamily: 'JosefinSans',
                    color: Color(0xff386063),
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 160,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Log In',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    color: Color.fromARGB(255, 2, 178, 248),
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                TextField1(
                  Enable: true,
                  secure_text: false,
                  controll: emaillogin,
                  isFocused: _isFocused,
                  icon1: Icons.person_2_sharp,
                  hint1: 'Email',
                ),
                SizedBox(
                  height: 34,
                ),
                TextField1(
                  Enable: true,
                  secure_text: true,
                  controll: passlogin,
                  isFocused: _isFocused,
                  icon1: Icons.lock,
                  hint1: 'Password',
                )
              ],
            ),
            Spacer(
              flex: 6,
            ),
            InkWell(
              onTap: () async {
                try {
                  final email_ = emaillogin.text;
                  final password_ = passlogin.text;
                  final user =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email_, password: password_);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xff1382E9), Color(0xff63B8C3)])),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterPage();
                    },
                  ),
                );
              },
              child: Center(
                child: Text(
                  'Dont have an accounts ',
                  style: TextStyle(
                      fontSize: 24, color: Colors.blue, fontWeight: FontWeight.w500, fontFamily: 'JosefinSans'),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
