import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/models/user.dart';
import 'package:googlelogin_firebase/pages/TimeLinePage.dart';
import 'package:googlelogin_firebase/pages/SearchPage.dart';
import 'package:googlelogin_firebase/pages/ProfilePage.dart';
import 'package:googlelogin_firebase/pages/UploadPage.dart';
import 'package:googlelogin_firebase/pages/NotificationsPage.dart';
import 'package:googlelogin_firebase/pages/CreateAccountPage.dart';
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

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isSignedIn = false;
  // 페이지 컨트롤
  PageController pageController;
  int currentPage = 0;

  List<Widget> pageList = [
    TimeLinePage(), // 0번 pageIndex
    SearchPage(), // 1번 pageIndex
    UploadPage(currentUser), // 2번 pageIndex
    NotificationsPage(), // 3번 pageIndex
    ProfilePage(currentUser.id),
  ];

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    pageController = PageController();

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

  // 로그인 상태 여부에 따라 isSignedIn flag값을 변경해줌
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
        await usersReference.doc(gCurrentUser.id).get();

    // 해당 유저의 db정보가 없다면
    if (!documentSnapshot.exists) {
      // 유저정보를 셋팅하는 페이지로 이동
      final username = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateAccountPage()));

      // 유저정보 셋팅된 값으로 db에 set
      usersReference.doc(gCurrentUser.id).set({
        'id': gCurrentUser.id,
        'profileName': gCurrentUser.displayName,
        'username': username,
        'url': gCurrentUser.photoUrl,
        'email': gCurrentUser.email,
        'bio': '',
        'timestamp': timestamp
      });

      // 해당 정보 다시 가져오기
      documentSnapshot = await usersReference.doc(gCurrentUser.id).get();
    }

    // 현재 유저정보에 값 셋팅하기
    currentUser = User.fromDocument(documentSnapshot);
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  loginUser() {
    googleSignIn.signIn();
  }

  buildHomeScreen() {
    return Scaffold(
      body: pageList[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 30.0), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add, size: 50.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30.0), label: ''),
        ],
      ),
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
                  'QQAQ',
                  style: TextStyle(fontSize: 50, fontFamily: 'Signatra'),
                ),
                SizedBox(height: 200),
                GestureDetector(
                  onTap: loginUser,
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Text(
                      '구글 로그인',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }
}
