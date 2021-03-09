import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// variable for google sign in (very easy to use)
final GoogleSignIn googleSignIn = new GoogleSignIn();
// variable for firestore collection 'users'
final usersReference =
    FirebaseFirestore.instance.collection('users'); // 사용자 정보 저장을 위한 ref
final firebase_storage.Reference storageReference =
    firebase_storage.FirebaseStorage.instance.ref().child('Posts Pictures');
final postsReference =
    FirebaseFirestore.instance.collection('users'); // 게시글 정보 저장을 위한 ref

final DateTime timestamp = DateTime.now();
User currentUser;

class SigninProvider extends ChangeNotifier {
  bool _isSigningIn;

  SigninProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future signInWithGoogle() async {
    isSigningIn = true;

    // 인증 흐름 트리거
    final gUser = await googleSignIn.signIn();
    if (gUser == null) {
      isSigningIn = false;
      return;
    } else {
      // 요청에서 인증 세부 정보 가져오기
      final googleAuth = await gUser.authentication;
      // 새 자격 증명 만들기
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = FirebaseAuth.instance.currentUser;
      final doc1 = FirebaseFirestore.instance.collection('user').doc(user.uid);
      DocumentSnapshot doc = await doc1.get();

      isSigningIn = false;
      return;
    }
  }
}
