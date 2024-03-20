import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../componant/user_list_widgt.dart';

class CompanyUserPage extends StatefulWidget {
  const CompanyUserPage({super.key});

  @override
  State<CompanyUserPage> createState() => _CompanyUserPageState();
}

class _CompanyUserPageState extends State<CompanyUserPage> {
  String? name;
  userdata() {}
  @override
  void initState() {
    userdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff1382E9), Color(0xff63B8C3)])),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).padding.top, 56),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 10),
                child: AppBar(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
                  elevation: 0,
                  backgroundColor: Colors.black.withOpacity(0.1),
                  centerTitle: true,
                  title: const Text(
                    'All Employes',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('UserData').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return company_user_list(
                            user_name: snapshot.data!.docs[index]['name'],
                            user_phoneNumber: snapshot.data!.docs[index]['phonenumber'],
                            user_id: snapshot.data!.docs[index]['id'],
                            user_jop: snapshot.data!.docs[index]['companypositin'],
                            user_email: snapshot.data!.docs[index]['email'],
                          );
                        });
                  } else {
                    return const Text('no Employes');
                  }
                }
              }
              return const Text('somthing went wrong');
            },
          ),
        ));
  }
}
