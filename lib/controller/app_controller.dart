import 'package:get/get.dart';

enum RouteName {
  TimeLinePage,
  SearchPage,
  UploadPage,
  NotificationsPage,
  ProfilePage
}

class AppController extends GetxService {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }
}
