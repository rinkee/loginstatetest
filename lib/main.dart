<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/App.dart';
import 'package:googlelogin_firebase/binding/init_binding.dart';
import 'package:googlelogin_firebase/models/user.dart';
import 'package:googlelogin_firebase/pages/CreateAccountPage.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/LoginPage.dart';
import 'dart:async';
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/pages/App.dart';
import 'package:googlelogin_firebase/provider/SigninProvider.dart';
import 'package:provider/provider.dart';
>>>>>>> 6ada9876745a1713c4ea75144d6842d45eb5e7cd

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
<<<<<<< HEAD
  runApp(MyApp());
}

bool isSignedIn = false;
// variable for google sign in (very easy to use)
final GoogleSignIn googleSignIn = new GoogleSignIn();
// variable for firestore collection 'users'
final userReference =
    FirebaseFirestore.instance.collection('users'); // 사용자 정보 저장을 위한 ref
final StorageReference storageReference =
    FirebaseStorage.instance.ref().child('Posts Pictures');
final postsReference =
    FirebaseFirestore.instance.collection('posts'); // 게시글 정보 저장을 위한 ref

final DateTime timestamp = DateTime.now();
User currentUser;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
=======

  runApp(MyApp());
>>>>>>> 6ada9876745a1713c4ea75144d6842d45eb5e7cd
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

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

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: InitBinding(),
      initialRoute: "/",
      getPages: [GetPage(name: "/", page: () => App())],
    );
  }
}

pages() {
  if (isSignedIn) {
    print('app');
    return App();
  } else {
    print('login');
    return LoginPage();
=======
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        cardColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<SigninProvider>(context);
          if (provider.isSigningIn) {
            return buildSignInScreen();
          } else if (!snapshot.hasData) {
            return
          }
          return App();
        }
      ),
    );
  }
  buildSignInScreen() {
    final provider = Provider.of<SigninProvider>(context);
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

                  onTap: provider.loginUser,
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
>>>>>>> 6ada9876745a1713c4ea75144d6842d45eb5e7cd
  }
}

