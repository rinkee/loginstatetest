import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/controller/app_controller.dart';
import 'package:googlelogin_firebase/pages/CreateAccountPage.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/LoginPage.dart';
import 'package:googlelogin_firebase/pages/NotificationsPage.dart';
import 'package:googlelogin_firebase/pages/ProfilePage.dart';
import 'package:googlelogin_firebase/pages/SearchPage.dart';
import 'package:googlelogin_firebase/pages/TimeLinePage.dart';
import 'package:googlelogin_firebase/pages/UploadPage.dart';

import 'models/user.dart';

User currentUser;

class App extends StatefulWidget {
  // 로그인 상태 여부에 따라 isSignedIn flag값을 변경해줌
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // 앱 실행시 구글 사용자의 변경여부를 확인함
    googleSignIn.onCurrentUserChanged.listen((gSignInAccount) {
      controlSignIn(gSignInAccount); // 사용자가 있다면 로그인
    }, onError: (gError) {
      print("Error Message : " + gError);
    });

    googleSignIn.signInSilently();
    // suppressErrors: false).then((gSignInAccount) {
    //   controlSignIn(gSignInAccount);
    // }).catchError((gError) {
    //   print("Error Message : " + gError);
    // });
  }

  bool isSignedIn = false;
  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await saveUserInfoToFirestore();
      setState(() {
        isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  saveUserInfoToFirestore() async {
    // 현재 구글 로그인된 사용자 정보 가져오기
    final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;
    // 해당 유저의 db정보 가져오기
    DocumentSnapshot documentSnapshot =
        await userReference.doc(gCurrentUser.id).get();

    // 해당 유저의 db정보가 없다면
    if (!documentSnapshot.exists) {
      // 유저정보를 셋팅하는 페이지로 이동
      final username = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateAccountPage()));

      // 유저정보 셋팅된 값으로 db에 set
      userReference.doc(gCurrentUser.id).set({
        'id': gCurrentUser.id,
        'profileName': gCurrentUser.displayName,
        'username': username,
        'url': gCurrentUser.photoUrl,
        'email': gCurrentUser.email,
        'bio': '',
        'timestamp': timestamp
      });

      // 해당 정보 다시 가져오기
      documentSnapshot = await userReference.doc(gCurrentUser.id).get();
    }

    // 현재 유저정보에 값 셋팅하기
    currentUser = User.fromDocument(documentSnapshot);
  }

  homepage() {
    return Scaffold(
      body: Obx(() {
        switch (RouteName.values[AppController.to.currentIndex.value]) {
          case RouteName.TimeLinePage:
            return TimeLinePage();
            break;
          case RouteName.SearchPage:
            return SearchPage();
            break;
          case RouteName.UploadPage:
            return UploadPage(currentUser);
            break;
          case RouteName.NotificationsPage:
            return NotificationsPage();
            break;
          case RouteName.ProfilePage:
            return ProfilePage(currentUser.id);
            break;
        }
        return Container();
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: AppController.to.currentIndex.value,
            showSelectedLabels: true,
            selectedItemColor: Colors.black54,
            onTap: AppController.to.changePageIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.photo_camera, size: 35), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          )),
    );
  }

  buildSignInScreen() {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Instargram',
                  style: TextStyle(
                      fontSize: 70,
                      color: Colors.black,
                      fontFamily: 'Signatra'),
                ),
                SizedBox(height: 200),
                FlatButton(onPressed: loginUser, child: Text('login'))
              ],
            )));
  }

  loginUser() {
    googleSignIn.signIn();
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return homepage();
    } else {
      return buildSignInScreen();
    }
  }
}
