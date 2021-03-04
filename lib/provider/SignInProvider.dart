import 'package:flutter/material.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// 구글
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// 카카오
// import 'package:kakao_flutter_sdk/all.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:uuid/uuid.dart';

import 'package:googlelogin_firebase/pages/CreateAccount.dart';

class SignInProvider extends ChangeNotifier {
  //구글
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  SignInProvider() {
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
      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

// Kakao Web Login

  // Future<UserCredential> signInWithKaKao() async {
  //   isSigningIn = true;
  //   final clientState = Uuid().v4();
  //   final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
  //     'response_type': 'code',
  //     'client_id': "f7dad7336683460c91b49ad855a03876",
  //     'response_mode': 'form_post',
  //     'redirect_uri':
  //     'https://garrulous-cyan-trader.glitch.me/callbacks/kakao/sign_in',
  //     'state': clientState,
  //   });
  //
  //   final result = await FlutterWebAuth.authenticate(
  //       url: url.toString(),
  //       callbackUrlScheme: "webauthcallback"); //"applink"//"signinwithapple"
  //   final body = Uri.parse(result).queryParameters;
  //   print(body);
  //
  //   final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token', {
  //     'grant_type': 'authorization_code',
  //     'client_id': "f7dad7336683460c91b49ad855a03876",
  //     'redirect_uri':
  //     'https://garrulous-cyan-trader.glitch.me/callbacks/kakao/sign_in',
  //     'code': body["code"],
  //   });
  //   var responseTokens = await http.post(tokenUrl.toString());
  //   Map<String, dynamic> bodys = json.decode(responseTokens.body);
  //   var response = await http.post(
  //       "https://garrulous-cyan-trader.glitch.me/callbacks/kakao/token",
  //       body: {"accessToken": bodys['access_token']});
  //
  //   await FirebaseAuth.instance.signInWithCustomToken(response.body);
  //   isSigningIn = false;
  // }
}
