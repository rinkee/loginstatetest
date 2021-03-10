import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/App.dart';
import 'package:provider/provider.dart';

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

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  loginUser() {
    googleSignIn.signIn();
  }

  @override
  Widget build(BuildContext context) {
    //로그인 프로바이더 가져오기
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('FOODMOOD'),
              FlatButton(
                onPressed: loginUser,
                child: Text('Google Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> addUserInFirestore() async {
//   final gCurrentUser = GoogleSignIn().currentUser;
//   final user = FirebaseAuth.instance.currentUser;
//   final doc1 = FirebaseFirestore.instance.collection('user').doc(user.uid);
//   DocumentSnapshot doc = await doc1.get();
//   // .get();
//   // Create a CollectionReference called users that references the firestore collection
//   CollectionReference users = FirebaseFirestore.instance.collection('user');
//   if (!doc.exists) {
//     doc1
//         .set({
//           'full_name': user.displayName, // John Doe
//           'nick_name:': nameController.text,
//           'photoURL': user.photoURL, // Stokes and Sons
//           'email': user.email // 42
//         })
//         .then((value) => print("User Added"))
//         .catchError((error) => print("Failed to add user: $error"));
//   }
// }
