import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlwaysMainScreen extends StatelessWidget {
  final User user;

  AlwaysMainScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are Logged in succesfully",
              style: TextStyle(color: Colors.lightBlue, fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            // Text(
            //   (() {
            //     if (user.phoneNumber == null) {
            //       return "Empty";
            //     } else {
            //       return "${user.phoneNumber}";
            //     }
            //   })(),
            //   style: TextStyle(
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
