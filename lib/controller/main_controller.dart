
import 'package:dithub/view/screen/friends_screen.dart';
import 'package:dithub/view/screen/home_screen.dart';
import 'package:dithub/view/screen/setting_screen.dart';
import 'package:dithub/view/screen/todo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/auth_service.dart';
import 'auth_controller.dart';

class MainController extends GetxController {
  var pageController = PageController();
  RxInt curPage = 0.obs;

  List<Widget> screens = [
    HomeScreen(),
    FriendsScreen(),
    TodoScreen(),
    SettingScreen(),
  ];

  User? get user => Get.find<AuthController>().user.value;

  onPageTapped(int v) {
    pageController.jumpToPage(v);
    curPage(v);
  }

  @override
  void onInit() {
    super.onInit();

    AuthService().saveUserInfoToFirestore(user!);
  }
}
