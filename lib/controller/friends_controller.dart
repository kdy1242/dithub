
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/friends_following_screen.dart';
import '../view/screen/friends_find_screen.dart';

class FriendsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> tabs = <Tab>[
    Tab(text: '팔로잉'),
    Tab(text: '친구 찾기'),
  ];

  final List<Widget> tabViews = <Widget>[
    FriendsFollowingScreen(),
    FriendsFindScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
