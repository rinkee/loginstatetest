import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/binding/init_binding.dart';
import 'package:googlelogin_firebase/pages/CreateAccount.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/LoginPage.dart';
import 'package:get/get.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  List<Widget> pageList = [HomePage(), MyPage()];

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
