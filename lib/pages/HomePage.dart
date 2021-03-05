import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlelogin_firebase/pages/CreatePost.dart';
import 'package:googlelogin_firebase/pages/TestPage.dart';
import 'package:provider/provider.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Login success'),
              FlatButton(
                onPressed: () {
                  Get.to(CreatePost());
                },
                child: Text('포스팅 하기'),
              ),
              FlatButton(
                onPressed: () {
                  provider.logout();
                },
                child: Text('logout'),
              ),
              FlatButton(
                onPressed: () {
                  Get.to(TestPage());
                },
                child: Text('업로드 이미지 테스트'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
