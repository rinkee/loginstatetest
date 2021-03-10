import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/App.dart';
import 'package:googlelogin_firebase/main.dart';
import 'package:googlelogin_firebase/widgets/HeaderWidget.dart';
import 'package:googlelogin_firebase/widgets/ProgressWidget.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Center(
        child: FlatButton(
          onPressed: logoutUser,
          child: Text('logout'),
        ),
      ),
    );
  }
}

logoutUser() async {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  await googleSignIn.signOut();
  FirebaseAuth.instance.signOut();
  Get.offAll(App());
}
