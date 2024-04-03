import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project4/componant/comment_card.dart';
import 'package:project4/componant/const.dart';
import 'package:project4/componant/small_button.dart';
import 'package:project4/componant/text1.dart';
import 'package:uuid/uuid.dart';

class TaskDetailsPage extends StatefulWidget {
  final String task__id;
  final String taskuploadedBy;
  final String userImage;
  const TaskDetailsPage({super.key, required this.task__id, required this.taskuploadedBy, required this.userImage});

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
  bool _isLoading = false;
  bool _isCommenting = false;
  final TextEditingController _commentControler = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _commentControler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    getdata2();

    super.initState();
  }

  getdata2() async {
    try {
      _isLoading = true;
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
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  getData() async {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // String uid = user!.uid;

    try {
      _isLoading = true;
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
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff1382E9), Color(0xff63B8C3)])),
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 30, right: 12, left: 12, bottom: 10),
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
                        Text(
                          task_title == null ? '' : task_title!,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 4, 66, 107)),
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
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'Task Date:',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 66, 107)),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 4, 66, 107)),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Upload by ',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 4, 66, 107)),
                                ),
                                const Spacer(
                                  flex: 7,
                                ),
                                CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: Colors.blueGrey,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(widget.userImage),
                                    radius: 17,
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
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(255, 4, 66, 107)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            const Row(
                              children: [
                                Text1(
                                  text: 'All Comments',
                                  fontsized1: 26,
                                  fontweights: FontWeight.w700,
                                  color: Color.fromARGB(255, 4, 66, 107),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              child: _isCommenting
                                  ? Row(
                                      children: [
                                        Flexible(
                                          child: TextField(
                                            maxLength: 100,
                                            maxLines: 6,
                                            controller: _commentControler,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Color.fromARGB(255, 242, 242, 242),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await uploadComment();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      color: const Color.fromARGB(255, 4, 66, 107),
                                                      borderRadius: BorderRadius.circular(6)),
                                                  child: const Text1(
                                                    text: 'Post',
                                                    fontsized1: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _isCommenting = false;
                                                  });
                                                },
                                                child: const Text1(
                                                  text: 'cancel',
                                                  fontsized1: 18,
                                                  color: Const.popTextColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isCommenting = !_isCommenting;
                                        });
                                      },
                                      child: const SmallButton(
                                        text: 'Upload Comment',
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance.collection('Tasks').doc(widget.task__id).get(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const SizedBox();
                                  } else {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    }
                                  }
                                  if (snapshot.hasError) {
                                    return const Text('data');
                                  } else {
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CommentCard(
                                            commentBody: snapshot.data!['taskComments'][index]['commentBody'],
                                            commentId: snapshot.data!['taskComments'][index]['commentId'],
                                            name: snapshot.data!['taskComments'][index]['name'],
                                            uploadedBy: snapshot.data!['taskComments'][index]['uploadedBy'],
                                            userImage: snapshot.data!['taskComments'][index]['userImage'],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 16,
                                          );
                                        },
                                        itemCount: snapshot.data!['taskComments'].length);
                                  }
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> uploadComment() async {
    if (_commentControler.text.length < 7) {
      await Fluttertoast.showToast(
          msg: "Enter 7 charecters ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          webBgColor: 'linear-gradient(to right, #DE9905, #EFB947)',
          fontSize: 16.0);
    } else {
      final generatedId = const Uuid().v4();
      await FirebaseFirestore.instance.collection('Tasks').doc(widget.task__id).update({
        'taskComments': FieldValue.arrayUnion(
          [
            {
              'uploadedBy': widget.taskuploadedBy,
              'commentId': generatedId,
              'name': user_name,
              'commentBody': _commentControler.text,
              'userImage': widget.userImage,
              'time': Timestamp.now()
            },
          ],
        ),
      });

      await Fluttertoast.showToast(
          msg: "Comment has been upload successfully ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          webBgColor: 'linear-gradient(to right, #DE9905, #EFB947)',
          fontSize: 16.0);
      _commentControler.clear();
    }
  }
}
