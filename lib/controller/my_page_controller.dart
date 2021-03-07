import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/Mockup_HomePage.dart';
import 'package:googlelogin_firebase/pages/MyPage.dart';

class MyPageController extends StatefulWidget {
  @override
  _MyPageControllerState createState() => _MyPageControllerState();
}

class _MyPageControllerState extends State<MyPageController> {
  int currentPage = 0;

  List<Widget> pageList = [
    Mockup_HomePage(),
    MyPage(),
    MyPage(),
    MyPage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              size: 30.0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 50.0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
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
