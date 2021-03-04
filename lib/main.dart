import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/LoginPage.dart';
import 'package:get/get.dart';

// 파이어베이스
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googlelogin_firebase/pages/MyPage.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
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
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => SignInProvider(),
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<SignInProvider>(context);

              if (provider.isSigningIn) {
                return buildLoading();
              } else if (!snapshot.hasData) {
                return LoginPage();
              } else {
                return Scaffold(
                  body: pageList[currentPage],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: currentPage,
                    selectedItemColor: Colors.redAccent,
                    unselectedItemColor: Colors.grey,
                    onTap: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.directions_run_rounded,
                          size: 30.0,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          size: 30.0,
                        ),
                        label: '',
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'FlutterBase',
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text('Flutterbase'),
//               backgroundColor: Colors.amber,
//             ),
//             body: Center(
//               child: Column(
//                 children: <Widget>[
//                   LoginButton(), // <-- Built with StreamBuilder
//                   UserProfile() // <-- Built with StatefulWidget
//                 ],
//               ),
//             )));
//   }
// }
