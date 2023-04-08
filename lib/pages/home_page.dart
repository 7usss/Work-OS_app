import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project4/componant/text1.dart';
import 'package:project4/pages/task_details_page.dart';
import 'package:uuid/uuid.dart';
import '../componant/drawer.dart';
import '../model/categorise_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final control_TaskCategory = TextEditingController(text: 'Category');
  final control_TaskTitle = TextEditingController();
  final control_TaskDiscription = TextEditingController();
  final control_TaskDeadLine = TextEditingController(text: 'Pick a date');
  DateTime? pick;
  Timestamp? TaskDeadLineTimeStamp;
  String? categoryfilter1;

  @override
  void dispose() {
    control_TaskCategory.dispose();
    control_TaskTitle.dispose();
    control_TaskDiscription.dispose();
    control_TaskDeadLine.dispose();

    // TODO: implement dispose
    super.dispose();
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 7, 218, 255),
          onPressed: () {
            setState(() {
              mytest();
            });
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        drawer: const Drawer1(),
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
                  actions: [
                    IconButton(
                        onPressed: () {
                          ShowDialogFunction(context);
                        },
                        icon: const Icon(
                          Icons.filter_list_sharp,
                          color: Colors.white,
                        ))
                  ],
                  centerTitle: true,
                  title: const Text(
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
                )),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Tasks')
              .where('taskCategory', isEqualTo: categoryfilter1)
              .snapshots(),
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
                        return TaskInHome(
                          task_description: snapshot.data!.docs[index]['taskDescription'],
                          task_title: snapshot.data!.docs[index]['taskTitle'],
                          task_id: snapshot.data!.docs[index]['taskId'],
                          task_uploadBy: snapshot.data!.docs[index]['uploadedBy'],
                          task_state: snapshot.data!.docs[index]['isDone'],
                        );
                      });
                } else {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            color: Colors.white,
                          ),
                          Center(
                            child: Text(
                              'There is no tasks in this Categoris',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }
            }
            return const Text('somthing went wrong');
          },
        ),
      ),
    );
  }

  void pickdate() async {
    pick = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2100));
    if (pick != null) {
      setState(() {
        TaskDeadLineTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(pick!.microsecondsSinceEpoch);
        control_TaskDeadLine.text = '${pick!.year}-${pick!.month}-${pick!.day}';
      });
    }
  }

  void mytest() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 70,
                    decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(64)),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Add Task',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 75, 75, 75),
                        fontFamily: 'JosefinSans'),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text1(
                        color: Color.fromARGB(255, 75, 75, 75),
                        text: 'Task Categorise*',
                        fontsized1: 16,
                        fontweights: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Textfieldfun(
                          fun: () {
                            ShowDialogFunction2(context);
                          },
                          valukey: 'TaskCategory',
                          controller: control_TaskCategory,
                          enable: false),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text1(
                        color: Color.fromARGB(255, 75, 75, 75),
                        text: 'Task Title*',
                        fontsized1: 16,
                        fontweights: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Textfieldfun(
                          fun: () {}, valukey: 'Tasktitle', controller: control_TaskTitle, enable: true, maxlenth: 50),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text1(
                        color: Color.fromARGB(255, 75, 75, 75),
                        text: 'Task Discription*',
                        fontsized1: 16,
                        fontweights: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Textfieldfun(
                          fun: () {},
                          valukey: 'TaskDiscription',
                          controller: control_TaskDiscription,
                          enable: true,
                          maxlenth: 1000),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text1(
                        color: Color.fromARGB(255, 75, 75, 75),
                        text: 'Dead line date*',
                        fontsized1: 16,
                        fontweights: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Textfieldfun(
                        fun: () {
                          pickdate();
                        },
                        valukey: 'Taskdate',
                        controller: control_TaskDeadLine,
                        enable: false,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (control_TaskCategory.text == 'Category' || control_TaskDeadLine.text == 'Pick a date') {
                        Fluttertoast.showToast(
                            msg: "please pick up evry thing ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 5,
                            webBgColor: 'linear-gradient(to right, #DE9905, #EFB947)',
                            fontSize: 16.0);
                      } else {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        User? user = auth.currentUser;
                        String uid = user!.uid;
                        final taskid = const Uuid().v4();
                        await FirebaseFirestore.instance.collection('Tasks').doc(taskid).set({
                          'taskId': taskid,
                          'uploadedBy': uid,
                          'taskTitle': control_TaskTitle.text,
                          'taskDescription': control_TaskDiscription.text,
                          'deadlineDate': control_TaskDeadLine.text,
                          'deadlineDateTimeStamp': TaskDeadLineTimeStamp,
                          'taskCategory': control_TaskCategory.text,
                          'isDone': false,
                          'createdAt': Timestamp.now(),
                        });
                        Fluttertoast.showToast(
                            msg: "Task has been Upload successfully ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            fontSize: 16.0);
                        Navigator.pop(context);
                        control_TaskTitle.clear();
                        control_TaskDiscription.clear();
                        setState(() {
                          control_TaskCategory.text = 'Category';
                          control_TaskDeadLine.text = 'Pick a date';
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
                      height: 40,
                      width: 200,
                      child: const Text(
                        'Upload Task',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 242, 245, 245),
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void ShowDialogFunction2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Categoris...',
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
                  itemCount: CategorisFilter.taskCategoriList.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          control_TaskCategory.text = CategorisFilter.taskCategoriList[index];
                        });
                        print('filter ${CategorisFilter.taskCategoriList[index]}');
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color.fromARGB(255, 41, 61, 66),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(CategorisFilter.taskCategoriList[index])
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

  ShowDialogFunction(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Categoris...',
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
                  itemCount: CategorisFilter.taskCategoriList.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                      onTap: () {
                        print('filter ${CategorisFilter.taskCategoriList[index]}');
                        setState(() {
                          categoryfilter1 = CategorisFilter.taskCategoriList[index];
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color.fromARGB(255, 41, 61, 66),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(CategorisFilter.taskCategoriList[index])
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
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    categoryfilter1 = null;
                  });
                },
                child: const Text('Cancele Filter'),
              ),
            ],
          );
        });
  }

  Textfieldfun(
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

class TaskInHome extends StatefulWidget {
  final String task_title;

  final String task_uploadBy;

  final String task_description;

  final String task_id;
  final bool task_state;
  const TaskInHome({
    super.key,
    required this.task_title,
    required this.task_uploadBy,
    required this.task_description,
    required this.task_id,
    required this.task_state,
  });

  @override
  State<TaskInHome> createState() => _TaskInHomeState();
}

class _TaskInHomeState extends State<TaskInHome> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: AlertDialog(
                  actions: [
                    InkWell(
                      onTap: () {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        User? user = auth.currentUser;
                        String uid = user!.uid;
                        if (uid == widget.task_uploadBy) {
                          FirebaseFirestore.instance.collection('Tasks').doc(widget.task_id).delete();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "The task  delete successfully",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              textColor: const Color.fromARGB(255, 255, 255, 255),
                              timeInSecForIosWeb: 4,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "You dont have permission to delete this task",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              textColor: const Color.fromARGB(255, 255, 255, 255),
                              timeInSecForIosWeb: 4,
                              webBgColor: 'linear-gradient(to right, #FD3A3D, #E63E40)',
                              fontSize: 16.0);
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaskDetailsPage(
            task__id: widget.task_id,
            taskuploadedBy: widget.task_uploadBy,
          );
        }));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(offset: Offset(0, 0), color: Color.fromARGB(31, 43, 43, 43), spreadRadius: 1, blurRadius: 7)
        ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            children: [
              widget.task_state == true
                  ? const Icon(
                      Icons.done,
                      size: 36,
                      color: Color.fromARGB(255, 98, 248, 93),
                    )
                  : const Icon(
                      Icons.alarm,
                      size: 36,
                      color: Color.fromARGB(255, 238, 174, 0),
                    ),
              const Spacer(
                flex: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task_title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    widget.task_description,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const Spacer(
                flex: 14,
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
