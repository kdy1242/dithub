
import 'dart:developer';

import 'package:dithub/controller/friends_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/friend.dart';
import 'auth_controller.dart';

class HomeController extends GetxController {
  PageController pageController = PageController();
  RxInt curPage = 0.obs;

  User? get user => Get.find<AuthController>().user.value;
  List<Friend> get followingList => Get.find<FriendsController>().followingList;

  onPageTapped(int v) {
    pageController.animateToPage(v, duration: Duration(milliseconds: 300), curve: Curves.ease);

    curPage.value = v;
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    curPage.value = 0;
  }
}
