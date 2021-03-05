import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlelogin_firebase/controller/app_controller.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';
import 'package:googlelogin_firebase/pages/MyPage.dart';

class App extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          showSelectedLabels: true,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            controller.changePageIndex(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: "home"),
          ],
        ),
      ),
      body: Obx(() {
        switch (RouteName.values[controller.currentIndex.value]) {
          case RouteName.Home:
            return HomePage();
            break;
          case RouteName.MyPage:
            return MyPage();
            break;
        }
        return Container();
      }),
    );
  }
}
