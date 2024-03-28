import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:spree_portal/services/send_notif.dart';

class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Enter Title of Notification',
                  labelStyle: GoogleFonts.jost(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange, width: 1)),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange, width: 1)),
                ),
                controller: title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Enter Body of Notification',
                  labelStyle: GoogleFonts.jost(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange, width: 1)),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orange, width: 1)),
                ),
                controller: body,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: NeoPopButton(
                  color: Colors.white,
                  shadowColor: Colors.orange,
                  onTapUp: () async {
                    final res = await SendNotif.send(
                        title.value.text, body.value.text);
                    Fluttertoast.showToast(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      msg: res.statusCode == 200
                          ? 'New Notification Sent!'
                          : 'Error in sending Notification!',
                      gravity: ToastGravity.BOTTOM,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Send Notification',
                      style: GoogleFonts.jost(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}