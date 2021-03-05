import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/MyPage.dart';

class MyPageController extends StatefulWidget {
  @override
  _MyPageControllerState createState() => _MyPageControllerState();
}

class _MyPageControllerState extends State<MyPageController> {
  int currentPage = 0;

  List<Widget> pageList = [HomePage(), MyPage()];

  @override
  Widget build(BuildContext context) {
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
}
