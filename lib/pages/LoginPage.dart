import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';
import 'package:provider/provider.dart';
import 'package:googlelogin_firebase/auth.dart';

class LoginPage extends StatelessWidget {
  // Future<UserCredential> signInWithGoogle() async {
  //   // 인증 흐름 트리거
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   // 요청에서 인증 세부 정보 가져오기
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //   // 새 자격 증명 만들기
  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   // 로그인한 후 UserCredential을 반환합니다.
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  Widget build(BuildContext context) {
    //로그인 프로바이더 가져오기
    final provider = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('FOODMOOD'),
              FlatButton(
                onPressed: () {
                  provider.signInWithGoogle();
                },
                child: Text('Google Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
