import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/binding/init_binding.dart';
import 'package:googlelogin_firebase/pages/CreateAccount.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/LoginPage.dart';
import 'package:get/get.dart';
import 'package:googlelogin_firebase/pages/Mockup_HomePage.dart';
import 'package:googlelogin_firebase/pages/TestPage.dart';
import 'App.dart';
import 'package:googlelogin_firebase/controller/my_page_controller.dart';

// 파이어베이스
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googlelogin_firebase/pages/MyPage.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => SignInProvider())],
    child: MyApp(),
  ));
  // runApp(MyApp());
}

final userReference =
    FirebaseFirestore.instance.collection('users'); // 사용자 정보 저장을 위한 ref
final StorageReference storageReference =
    FirebaseStorage.instance.ref().child('Posts Pictures');
final postsReference =
    FirebaseFirestore.instance.collection('posts'); // 게시글 정보 저장을 위한 ref

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(name: '/second', page: () => MyPage()),
      ],
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<SignInProvider>(context);
          if (provider.isSigningIn) {
            return buildLoading();
          } else if (!snapshot.hasData) {
            return LoginPage();
          } else if (snapshot.hasData && provider.haveCreated) {
            print(provider.haveCreated);
            return CreateAccount();
          } else {
            return MyPageController();
            // return App();

          }
        },
      ),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
