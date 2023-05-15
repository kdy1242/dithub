
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dithub/model/Friend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/friends_following_screen.dart';
import '../view/screen/friends_find_screen.dart';
import 'auth_controller.dart';

class FriendsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Rxn<Friend> searchResult = Rxn();
  RxList<Friend> followingList = <Friend>[].obs;

  TextEditingController searchEmailController = TextEditingController();

  FirebaseFirestore instance = FirebaseFirestore.instance;

  User? get user => Get.find<AuthController>().user.value;

  final List<Tab> tabs = <Tab>[
    Tab(text: '팔로잉'),
    Tab(text: '친구 찾기'),
  ];

  final List<Widget> tabViews = <Widget>[
    FriendsFollowingScreen(),
    FriendsFindScreen(),
  ];

  // 친구 검색
  searchFriend() async {
    var res = await instance.collection('users').where('email', isEqualTo: searchEmailController.text).get();
    // searchResult(res.docs.first.data());

    if (res.docs.isNotEmpty) {
      searchResult(Friend.fromMap(res.docs.first.data()));
      print(searchResult);
    } else {
      searchResult(null);
    }
  }

  // 팔로잉
  followFriend() async {
    await instance.collection('following').doc(user!.uid).update({
      'following': FieldValue.arrayUnion([searchResult.value!.uid]),
    });
  }

  // 팔로우중인 친구 가져오기
  getFollowFriends() async {
    var res = await instance.collection('following').doc(user!.uid).get();
    log('${res.data()}');
    if (res.data() != null) {
      List followingField = res.data()!['following'];
      List<Friend> friendsList = followingList.value ?? [];

      for (var friendId in followingField) {
        var friendData = await instance.collection('users').where('uid', isEqualTo: friendId).get();
        friendsList.add(Friend.fromMap(friendData.docs.first.data()));
      }
      followingList(friendsList);

      print(followingField);
      log('${friendsList}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    getFollowFriends();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
