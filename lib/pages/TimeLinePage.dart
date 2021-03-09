import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/pages/App.dart';
import 'package:googlelogin_firebase/pages/UploadPage.dart';
import 'package:googlelogin_firebase/widgets/HeaderWidget.dart';
import 'package:googlelogin_firebase/widgets/ProgressWidget.dart';
import 'package:googlelogin_firebase/models/user.dart';

User currentUser;

final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timeline',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadPage(currentUser)));
                },
                child: Text('포스트 쓰기'))
          ],
        ),
      ),
    );
  }
}
