import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project4/componant/const.dart';
import 'package:project4/pages/login_page.dart';

import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: Const.selectionsColor, cursorColor: Const.cursorColor),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Const.textFieldColor),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: buildFirstWidget(),
  ));
}

Widget buildFirstWidget() {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;

  if (firebaseUser == null) {
    return const LoginPage();
  } else {
    return const MyApp();
  }
}
