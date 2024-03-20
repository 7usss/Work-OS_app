import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskDetailsPage extends StatefulWidget {
  final String task__id;
  final String taskuploadedBy;
  const TaskDetailsPage({super.key, required this.task__id, required this.taskuploadedBy});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  String? user_name;
  String? user_jop;
  String? task_title;
  String? task_description;
  String? task_deadline;
  String? task_uploadBy;
  String? task_uploadDate;
  bool? taskstate;

  @override
  void initState() {
    getData();
    getdata2();

    super.initState();
  }

  getdata2() async {
    final DocumentSnapshot taskDoc = await FirebaseFirestore.instance.collection('Tasks').doc(widget.task__id).get();
    setState(() {
      task_title = taskDoc.get('taskTitle');
      task_description = taskDoc.get('taskDescription');
      task_deadline = taskDoc.get('deadlineDate');
      taskstate = taskDoc.get('isDone');
      Timestamp taskUploadtimestamp = taskDoc.get('createdAt');
      var taskUploadtoDate = taskUploadtimestamp.toDate();
      task_uploadDate = '${taskUploadtoDate.year}-${taskUploadtoDate.month}-${taskUploadtoDate.day}';
    });
  }

  getData() async {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // String uid = user!.uid;
    try {
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('UserData').doc(widget.taskuploadedBy).get();
      setState(() {
        user_name = userDoc.get('name');
        user_jop = userDoc.get('companypositin');
        // Timestamp userJointimestamp = userDoc.get('CreateAt');
        // var userJoindatestring = userJointimestamp.toDate();
        // user_joinDate = '${userJoindatestring.year}-${userJoindatestring.month}-${userJoindatestring.day}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff1382E9), Color(0xff63B8C3)])),
        child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).padding.top, 56),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 10),
                  child: AppBar(
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
                    elevation: 0,
                    backgroundColor: Colors.black.withOpacity(0.1),
                    centerTitle: true,
                    title: const Text(
                      'Task details',
                      style: TextStyle(
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
            body: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(
                top: 70,
                right: 12,
                left: 12,
              ),
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
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Task Title',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 66, 107)),
                        ),
                      ),
                      Text(
                        task_title == null ? '' : task_title!,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 4, 66, 107)),
                      ),
                      const SizedBox(
                        height: 4,
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
                              'Task Date:',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 66, 107)),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Start Date',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 4, 66, 107)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  task_uploadDate == null ? '' : task_uploadDate!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromARGB(255, 4, 66, 107)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Deadline Date',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 4, 66, 107)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  task_deadline == null ? '' : task_deadline!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromARGB(255, 202, 3, 13)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const Text(
                            'Done State:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 66, 107)),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                  User? user = auth.currentUser;
                                  String uid = user!.uid;
                                  if (uid == widget.taskuploadedBy) {
                                    setState(() {});
                                    FirebaseFirestore.instance
                                        .collection('Tasks')
                                        .doc(widget.task__id)
                                        .update({'isDone': true});
                                    getdata2();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "You dont have permission to change this task",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        textColor: const Color.fromARGB(255, 255, 255, 255),
                                        timeInSecForIosWeb: 4,
                                        webBgColor: 'linear-gradient(to right, #FD3A3D, #E63E40)',
                                        fontSize: 16.0);
                                  }
                                },
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 4, 66, 107),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Opacity(
                                  opacity: taskstate == true ? 1 : 0,
                                  child: const Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                  User? user = auth.currentUser;
                                  String uid = user!.uid;
                                  if (uid == widget.taskuploadedBy) {
                                    setState(() {});
                                    FirebaseFirestore.instance
                                        .collection('Tasks')
                                        .doc(widget.task__id)
                                        .update({'isDone': false});
                                    getdata2();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "You dont have permission to change this task",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        textColor: const Color.fromARGB(255, 255, 255, 255),
                                        timeInSecForIosWeb: 4,
                                        webBgColor: 'linear-gradient(to right, #FD3A3D, #E63E40)',
                                        fontSize: 16.0);
                                  }
                                },
                                child: const Text(
                                  'Not Done',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 4, 66, 107),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Opacity(
                                  opacity: taskstate == false ? 1 : 0,
                                  child: const Icon(
                                    Icons.check_box,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const Text(
                            'Task Description:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 66, 107)),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 240, 238, 238)),
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              task_description == null ? '' : task_description!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 4, 66, 107)),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Upload by ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 4, 66, 107)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      user_name == null ? '' : user_name!,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromARGB(255, 4, 66, 107)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      user_jop == null ? '' : user_jop!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromARGB(255, 4, 66, 107)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
            )));
  }
}
