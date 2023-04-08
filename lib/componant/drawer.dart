import 'package:flutter/material.dart';
import 'package:project4/pages/company_use_pager.dart';
import 'package:project4/pages/home_page.dart';
import 'package:project4/pages/profile_page.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(25),
        topRight: Radius.circular(25),
      )),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color.fromARGB(255, 19, 137, 233), Color(0xff63B8C3)]),
              borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
            ),
            child: Center(
              child: Text(
                '',
                style: TextStyle(fontFamily: 'JosefinSans', fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            leading: const Icon(Icons.task),
            iconColor: const Color.fromARGB(255, 40, 140, 255),
            title: const Text(
              'All Task',
              style: TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
          ),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            leading: const Icon(Icons.person),
            iconColor: const Color.fromARGB(255, 40, 140, 255),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfilePage();
              }));
            },
          ),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            leading: const Icon(Icons.group),
            iconColor: const Color.fromARGB(255, 7, 123, 255),
            title: const Text(
              'CompanyUser',
              style: TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CompanyUserPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
