import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/pages/App.dart';
import 'package:googlelogin_firebase/provider/SigninProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  }
}

