// import 'package:flutter/material.dart';
// import 'package:project4/componant/text1.dart';

// class FloatingBottom extends StatefulWidget {
//   const FloatingBottom({super.key});

//   @override
//   State<FloatingBottom> createState() => _FloatingBottomState();
// }

// class _FloatingBottomState extends State<FloatingBottom> {
//   void mytest() {
//     setState(() {
//       showModalBottomSheet(
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.horizontal(left: Radius.circular(25), right: Radius.circular(25))),
//           context: context,
//           builder: (context) {
//             return Container(
//                 margin: const EdgeInsets.all(8),
//                 child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
//                   const Text(
//                     'Add Task',
//                     style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 75, 75, 75),
//                         fontFamily: 'JosefinSans'),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(14), color: const Color.fromARGB(0, 228, 207, 207)),
//                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Row(children: const [
//                         Text1(
//                           text: ' Name',
//                           fontsized1: 24,
//                           color: Color.fromARGB(255, 75, 75, 75),
//                           fontweights: FontWeight.bold,
//                         ),
//                       ]))
//                 ]));
//           });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
