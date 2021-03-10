<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/App.dart';
import 'package:googlelogin_firebase/main.dart';
import 'package:googlelogin_firebase/widgets/HeaderWidget.dart';
import 'package:googlelogin_firebase/widgets/ProgressWidget.dart';
=======
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/pages/App.dart';
import 'package:googlelogin_firebase/pages/UploadPage.dart';
import 'package:googlelogin_firebase/widgets/HeaderWidget.dart';
import 'package:googlelogin_firebase/widgets/ProgressWidget.dart';
import 'package:googlelogin_firebase/models/user.dart';

User currentUser;

final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;
>>>>>>> 6ada9876745a1713c4ea75144d6842d45eb5e7cd

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: header(context, isAppTitle: true),
      body: Center(
        child: FlatButton(
          onPressed: logoutUser,
          child: Text('logout'),
=======
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
>>>>>>> 6ada9876745a1713c4ea75144d6842d45eb5e7cd
        ),
      ),
    );
  }
}
<<<<<<< HEAD

logoutUser() async {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  await googleSignIn.signOut();
  FirebaseAuth.instance.signOut();
  Get.offAll(App());
}
=======
>>>>>>> 6ada9876745a1713c4ea75144d6842d45eb5e7cd
