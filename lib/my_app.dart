import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project4/pages/company_use_pager.dart';
import 'package:project4/pages/home_page.dart';
import 'package:project4/pages/profile_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _selectedIndex = 0;

  final List<Widget> pages = [const HomePage(), const ProfilePage(), CompanyUserPage()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: pages.elementAt(_selectedIndex)),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(131, 231, 231, 231)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              tabBackgroundGradient: LinearGradient(colors: [
                Color.fromARGB(190, 125, 165, 201),
                Color.fromARGB(255, 49, 114, 205).withOpacity(0.5),
              ]),
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: const Color.fromARGB(255, 89, 144, 211),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
                GButton(
                  icon: Icons.group,
                  text: 'Employes',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
}
