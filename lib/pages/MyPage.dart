import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //로그인 프로바이더 가져오기
    final provider = Provider.of<SignInProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('MyPage'),
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
                radius: 60.0,
              ),
              Text(user.displayName),
              Text(user.uid),
              FlatButton(
                onPressed: () {
                  provider.logout();
                },
                child: Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
