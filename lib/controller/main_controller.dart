
import 'dart:developer';

import 'package:dithub/view/screen/friends_screen.dart';
import 'package:dithub/view/screen/home_screen.dart';
import 'package:dithub/view/screen/setting_screen.dart';
import 'package:dithub/view/screen/todo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var pageController = PageController();
  RxInt curPage = 0.obs;

  List<Widget> screens = [
    HomeScreen(),
    FriendsScreen(),
    TodoScreen(),
    SettingScreen(),
  ];

  User? get user => FirebaseAuth.instance.currentUser;

  onPageTapped(int v) {
    pageController.jumpToPage(v);
    curPage(v);
  }

  @override
  void onInit() {
    super.onInit();
    log('main onInit: ${FirebaseAuth.instance.currentUser!.displayName}');
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    curPage(0);
  }
}
