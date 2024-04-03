import 'package:flutter/material.dart';
import 'package:project4/componant/text1.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(
      {super.key,
      required this.commentBody,
      required this.commentId,
      required this.name,
      required this.uploadedBy,
      required this.userImage});
  final String commentBody;
  final String commentId;
  final String name;
  final String uploadedBy;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return name == ''
        ? const Text('')
        : Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 242, 242),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                name == ''
                    ? const Text('')
                    : CircleAvatar(
                        maxRadius: 23,
                        backgroundColor: Colors.blueGrey,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                          radius: 20,
                        ),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text1(
                      text: name,
                      fontsized1: 20,
                      fontweights: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text1(
                        text: commentBody,
                        fontsized1: 18,
                        fontweights: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
