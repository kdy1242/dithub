
import 'dart:developer';

import 'package:dithub/controller/friends_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/friend.dart';
import 'auth_controller.dart';

class HomeController extends GetxController {
  PageController pageController = PageController();
  RxInt selectedIndex = 0.obs;

  User? get user => FirebaseAuth.instance.currentUser;
  List<Friend> get followingList => Get.find<FriendsController>().followingList;

  onPageTapped(int v) {
    pageController.animateToPage(v, duration: Duration(milliseconds: 300), curve: Curves.ease);

    selectedIndex.value = v;
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    selectedIndex.value = 0;
  }
}
