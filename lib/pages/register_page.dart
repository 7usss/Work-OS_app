import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../model/categorise_filter.dart';
import '../componant/text_field1.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final emailregister = TextEditingController();
  final passregister = TextEditingController();
  final phonenumber = TextEditingController();
  final companypositin = TextEditingController(text: 'Company Position');
  final bool _isFocused = false;

  late String imageUrl;
  static bool imageAvailable = false;

  @override
  void dispose() {
    emailregister.dispose();
    username.dispose();
    phonenumber.dispose();
    companypositin.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void pick_image() async {
    final image = await ImagePickerWeb.getImageAsFile();
    final ref = FirebaseStorage.instance.ref().child("bills/55/33.jpeg");
    await ref.putFile(image! as File);
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
      imageAvailable = true;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Row(
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
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    color: Color.fromARGB(255, 2, 178, 248),
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                // Stack(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         ShowDialogFunction2(context);
                //       },
                //       child: Container(
                //           height: 100,
                //           width: 100,
                //           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                //           clipBehavior: Clip.hardEdge,
                //           child: imageAvailable
                //               ? Image.network(
                //                   imageUrl,
                //                   fit: BoxFit.cover,
                //                 )
                //               : Image.network(
                //                   'https://t3.ftcdn.net/jpg/03/39/45/96/360_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg',
                //                   fit: BoxFit.cover,
                //                 )),
                //     ),
                //     const Positioned(
                //         bottom: 0,
                //         right: 0,
                //         child: CircleAvatar(
                //             backgroundColor: Color.fromARGB(255, 245, 97, 86),
                //             radius: 18,
                //             child: Icon(
                //               Icons.camera_enhance,
                //               color: Colors.white,
                //             )))
                //   ],
                // ),
                const SizedBox(
                  height: 28,
                ),
                TextField1(
                  Enable: true,
                  secure_text: false,
                  controll: username,
                  isFocused: true,
                  hint1: 'Username',
                ),
                const SizedBox(
                  height: 28,
                ),
                TextField1(
                  Enable: true,
                  secure_text: false,
                  controll: emailregister,
                  isFocused: true,
                  hint1: 'Email',
                ),
                const SizedBox(
                  height: 28,
                ),
                TextField1(
                  Enable: true,
                  secure_text: false,
                  controll: phonenumber,
                  isFocused: false,
                  hint1: 'Phone',
                ),
                const SizedBox(
                  height: 28,
                ),
                TextField1(
                  Enable: true,
                  secure_text: true,
                  controll: passregister,
                  isFocused: true,
                  hint1: 'Password',
                ),
                const SizedBox(
                  height: 28,
                ),
                Textfieldfun(
                    valukey: 'company',
                    controller: companypositin,
                    enable: false,
                    fun: () {
                      ShowDialogFunction3(context);
                    })
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                try {
                  final username1 = username.text;
                  final phonenumber1 = phonenumber.text;
                  final joptitle1 = companypositin.text;
                  final Email = emailregister.text;
                  final Pass = passregister.text;

                  final newuser =
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Pass).then((value) {
                    FirebaseFirestore.instance.collection('UserData')
                      ..doc(value.user!.uid).set({
                        'id': value.user!.uid,
                        'email': value.user!.email,
                        'name': username1,
                        'phonenumber': phonenumber1,
                        'companypositin': joptitle1,
                        // 'image_url': imageUrl
                        'CreateAt': Timestamp.now(),
                      });
                  });

                  if (newuser != null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }));
                  } else {
                    print('false input');
                  }
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
                child: const Text(
                  'Register',
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
              onTap: () => Navigator.pop(context),
              child: const Center(
                child: Text(
                  'Alredy have an accounts',
                  style: TextStyle(
                      fontSize: 24, color: Colors.blue, fontWeight: FontWeight.w500, fontFamily: 'JosefinSans'),
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            )
          ],
        ),
      ),
    );
  }

  void ShowDialogFunction2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Choose an option',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 34, 58, 59),
              fontFamily: 'JosefinSans',
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: pick_image,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Color.fromARGB(255, 41, 61, 66),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('From Gallary'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Color.fromARGB(255, 41, 61, 66),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Take picture'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        );
      },
    );
  }

  void ShowDialogFunction3(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Jop title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 34, 58, 59),
                fontFamily: 'JosefinSans',
                fontSize: 20,
              ),
            ),
            content: SizedBox(
              width: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: CategorisFilter.jobsList.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          companypositin.text = CategorisFilter.jobsList[index];
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.title_outlined,
                            color: Color.fromARGB(255, 41, 61, 66),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(CategorisFilter.jobsList[index])
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  static Textfieldfun(
      {int? maxlenth,
      required String valukey,
      required TextEditingController controller,
      required bool enable,
      required Function fun}) {
    return InkWell(
      onTap: () {
        fun();
      },
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        enabled: enable,
        maxLines: valukey == 'TaskDiscription' ? 3 : 1,
        maxLength: maxlenth,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 88, 106, 109),
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
