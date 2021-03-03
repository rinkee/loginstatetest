import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/pages/LoginPage.dart';
import 'package:get/get.dart';

// 파이어베이스
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final
        },
      )
    );
  }
}
LoginPage(),