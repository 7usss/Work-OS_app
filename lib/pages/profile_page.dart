import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? user_email;
  String? user_name;
  String? user_phoneNumber;
  String? user_jop;
  String? user_image;
  String? user_joinDate;
  bool isSameuser = false;

  @override
  void initState() {
    getData();

    super.initState();
  }

  // getdata() async {
  //   final User? user = await FirebaseAuth.instance.currentUser;
  //   user_email = user!.email;
  //   _uid = await user.uid;
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UserData').doc(_uid).get();
  //   user_name = await userDoc.get('name');
  //   user_phoneNumber = await userDoc.get('phonenumber');
  // }
  getData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
        if (userDoc == null) {
          return;
        } else {
          setState(() {
            user_name = userDoc.get('name');
            user_email = userDoc.get('email');
            user_image = userDoc.get('image_url');
            user_phoneNumber = userDoc.get('phonenumber');
            user_jop = userDoc.get('companypositin');
            Timestamp userJointimestamp = userDoc.get('CreateAt');
            var userJoindatestring = userJointimestamp.toDate();
            user_joinDate = '${userJoindatestring.year}-${userJoindatestring.month}-${userJoindatestring.day}';
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                'https://cdn.discordapp.com/attachments/679377927611351119/1076211185248108664/Frame_11.png',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.1),
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 26,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    user_image == null
                        ? const CircleAvatar(
                            maxRadius: 55,
                            backgroundColor: Colors.blueGrey,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
                              radius: 50,
                            ),
                          )
                        : CircleAvatar(
                            maxRadius: 55,
                            backgroundColor: Colors.blueGrey,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user_image!),
                              radius: 50,
                            ),
                          ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      user_name == null ? '' : user_name!,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 4, 66, 107)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user_jop == null ? '' : user_jop!,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 4, 66, 107),
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'since joined in :',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 4, 66, 107),
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                    Text(
                      user_joinDate == null ? '' : user_joinDate!,
                      style: const TextStyle(
                          fontSize: 22,
                          overflow: TextOverflow.fade,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 4, 66, 107),
                          fontStyle: FontStyle.italic),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Contact Info:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 66, 107)),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'Email:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 4, 66, 107)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                user_email == null ? '' : '$user_email',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 4, 66, 107)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'Phone:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 4, 66, 107)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                user_phoneNumber == null ? '' : '$user_phoneNumber',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 4, 66, 107)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 8),
                        //       child: SizedBox(
                        //         height: 60,
                        //         width: 60,
                        //         child: Image.network(
                        //           'https://cdn.discordapp.com/attachments/679377927611351119/1077036608500539432/86.png',
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 8),
                        //       child: SizedBox(
                        //         height: 60,
                        //         width: 60,
                        //         child: Image.network(
                        //           'https://cdn.discordapp.com/attachments/679377927611351119/1077033868957339748/86.png',
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 8),
                        //       child: SizedBox(
                        //         height: 60,
                        //         width: 60,
                        //         child: Image.network(
                        //           'https://cdn.discordapp.com/attachments/679377927611351119/1077033838598967367/77.png',
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 36),
                              alignment: Alignment.center,
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(34),
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Color.fromARGB(201, 241, 9, 9), Color.fromARGB(192, 221, 4, 4)])),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
