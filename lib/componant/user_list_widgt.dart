import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:url_launcher/url_launcher.dart';

class company_user_list extends StatefulWidget {
  final String user_id;
  final String user_name;
  final String user_phoneNumber;
  final String user_jop;
  final String user_email;

  const company_user_list({
    super.key,
    required this.user_id,
    required this.user_name,
    required this.user_phoneNumber,
    required this.user_jop,
    required this.user_email,
  });

  @override
  State<company_user_list> createState() => _company_user_listState();
}

class _company_user_listState extends State<company_user_list> {
  // mailfun() async {
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: widget.user_email,
  //   );
  //   String url = params.toString();
  //   if (await canLaunchUrl(params)) {
  //     await launchUrl(params);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // final Uri url = Uri(
  //   scheme: 'mailto',
  //   path: 'hasooooomi52@gmail.com',
  // );

  // void whatsUppfun() async {
  //   await launch('https://wa.me/${widget.user_phoneNumber}?text=Hi');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(offset: Offset(0, 0), color: Color.fromARGB(31, 43, 43, 43), spreadRadius: 1, blurRadius: 7)
      ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
                clipBehavior: Clip.hardEdge,
                height: 50,
                width: 50,
                child: InkWell(
                  // onTap: whatsUppfun,
                  child: Image.network(
                    'https://imgs.search.brave.com/3LdTtWOHApyI__t3Vd2d8Ysb7r3YV6aX4Np2O7c92Mk/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9wbmdp/bWcuY29tL3VwbG9h/ZHMvd2hhdHNhcHAv/d2hhdHNhcHBfUE5H/MTUucG5n',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user_name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  widget.user_jop,
                  style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
                Text(
                  widget.user_phoneNumber,
                  style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                )
              ],
            ),
            const Spacer(
              flex: 14,
            ),
            InkWell(
              // onTap: () async {
              //   if (await canLaunchUrl(url)) {
              //     launchUrl(url);
              //   } else {
              //     await Fluttertoast.showToast(
              //         msg: "Can't send this Email",
              //         toastLength: Toast.LENGTH_LONG,
              //         gravity: ToastGravity.CENTER,
              //         timeInSecForIosWeb: 5,
              //         webBgColor: 'linear-gradient(to right, #DE9905, #EFB947)',
              //         fontSize: 16.0);
              //   }
              // },
              child: const Icon(
                Icons.email_outlined,
                color: Color.fromARGB(255, 0, 40, 66),
              ),
            )
          ],
        ),
      ),
    );
  }
}
