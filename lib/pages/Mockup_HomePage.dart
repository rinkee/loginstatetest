import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlelogin_firebase/pages/CreatePost.dart';
import 'package:googlelogin_firebase/pages/TestPage.dart';
import 'package:provider/provider.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';

class Mockup_HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'NANOBOB',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: ListView(
                      children: [
                        MyFoodContent(
                          foodUrl:
                              'https://postfiles.pstatic.net/MjAyMDEyMTJfMjk4/MDAxNjA3NzY1MjM0ODM4.QUQ7vgDGEl4bbPSlodNYThI44JUv_UyLdv_RAHi7po8g.Rr4KHWA3xpnInWN4VEGI83xe7tkGnIc_bX6mESI7ZPAg.JPEG.k06235/IMG_9106.jpg?type=w580',
                          store: '00마라탕',
                          menu: '마라탕 중',
                        ),
                        SizedBox(height: 20),
                        MyFoodContent(
                          foodUrl:
                              'https://postfiles.pstatic.net/MjAyMDEyMTJfMTA2/MDAxNjA3NzY1MjM0OTEx.qz2AtrJ8QNhT7eo1dlRekSJMSiWLC0K-XqshrtjwK3Qg.zOMJ-lQynumt7Q1Mhg5RqRx8qR0_2S87T8tOYmtD80Yg.JPEG.k06235/IMG_9580.JPG?type=w580',
                          store: '볶는 사람들',
                          menu: '야채곱창,곱창볶음',
                        ),
                        SizedBox(height: 20),
                        MyFoodContent(
                          foodUrl:
                              'https://postfiles.pstatic.net/MjAyMDEyMTJfMjUg/MDAxNjA3NzY1MjM1NDc0.YJCERjFfOxTCcl7V3jzm7wnoq7iyia7i1k5M9tUPc1gg.__9d7HbihmzGE31elLo_E1b1u8E0EZ3WcXPlgKVLFfEg.JPEG.k06235/IMG_3843.jpg?type=w580',
                          store: '파파스타타',
                          menu: '스테이크 크림 파스타',
                        ),
                        SizedBox(height: 20),
                        MyFoodContent(
                          foodUrl:
                              'https://postfiles.pstatic.net/MjAyMDEyMTJfMjgz/MDAxNjA3NzY1MjM0ODk4.wmtRtN_CyWssfhWPdEaGsJSo3BGXsxuJF1mafinyq24g.rxD5I9JARr3AEbaR-fmfOygqG5J6a_WpSdjHkBMjn7Yg.JPEG.k06235/IMG_1900.jpg?type=w580',
                          store: '푸라닭',
                          menu: '고추마요',
                        ),
                        SizedBox(height: 20),
                        MyFoodContent(
                          foodUrl:
                              'https://postfiles.pstatic.net/MjAyMDEyMTJfMjgz/MDAxNjA3NzY1MjM0ODk4.wmtRtN_CyWssfhWPdEaGsJSo3BGXsxuJF1mafinyq24g.rxD5I9JARr3AEbaR-fmfOygqG5J6a_WpSdjHkBMjn7Yg.JPEG.k06235/IMG_1900.jpg?type=w580',
                          store: '푸라닭',
                          menu: '고추마요',
                        ),
                        SizedBox(height: 20),
                        MyFoodContent(
                          foodUrl:
                              'https://postfiles.pstatic.net/MjAyMDEyMTJfMjgz/MDAxNjA3NzY1MjM0ODk4.wmtRtN_CyWssfhWPdEaGsJSo3BGXsxuJF1mafinyq24g.rxD5I9JARr3AEbaR-fmfOygqG5J6a_WpSdjHkBMjn7Yg.JPEG.k06235/IMG_1900.jpg?type=w580',
                          store: '푸라닭',
                          menu: '고추마요',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Column(
              //   children: [
              //     RightMenu(
              //       menuIcon: Icons.food_bank,
              //       title: "맛집",
              //     ),
              //     RightMenu(
              //       menuIcon: Icons.kitchen,
              //       title: "식품",
              //     ),
              //     RightMenu(
              //       menuIcon: Icons.liquor,
              //       title: "주류",
              //     ),
              //     RightMenu(
              //       menuIcon: Icons.icecream,
              //       title: "디저트",
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class RightMenu extends StatelessWidget {
  RightMenu({this.menuIcon, this.title});

  IconData menuIcon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 70,
        color: Colors.brown[400],
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                menuIcon,
                size: 25,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFoodContent extends StatelessWidget {
  MyFoodContent({this.foodUrl, this.store, this.menu});

  String foodUrl;
  String store;
  String menu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          foodUrl,
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                menu,
                style: TextStyle(color: Colors.black54),
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
              )
            ],
          ),
        )
      ],
    );
  }
}
