
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dithub/model/friend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/fonts.dart';
import '../view/screen/friends_following_screen.dart';
import '../view/screen/friends_find_screen.dart';
import 'auth_controller.dart';

class FriendsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Rxn<Friend> searchResult = Rxn();
  RxList<Friend> followingList = <Friend>[].obs;

  TextEditingController searchEmailController = TextEditingController();

  FirebaseFirestore instance = FirebaseFirestore.instance;

  User? get user => FirebaseAuth.instance.currentUser;

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
    final followDocRef = instance.collection('following').doc(user!.uid);

    final followDocSnapshot = await followDocRef.get();

    if (followDocSnapshot.exists) {
      // 문서가 이미 존재하는 경우 업데이트
      await followDocRef.update({
        'following': FieldValue.arrayUnion([searchResult.value!.uid]),
      });
    } else {
      // 문서가 존재하지 않는 경우 생성
      await followDocRef.set({
        'following': [searchResult.value!.uid],
      });
    }
    followingList.add(searchResult.value!);
  }

  // 팔로우중인 친구 가져오기
  getFollowFriends() async {
    var res = await instance.collection('following').doc(user!.uid).get();
    log('${res.data()}');
    if (res.data() != null) {
      List followingField = res.data()!['following'];

      for (var friendId in followingField) {
        var friendData = await instance.collection('users').where('uid', isEqualTo: friendId).get();
        followingList.add(Friend.fromMap(friendData.docs.first.data()));
      }

      print(followingField);
    }
  }

  // 친구 삭제
  onTapDeleteBtn(Friend friend) async {
    Get.defaultDialog(
      title: '친구 삭제',
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      content: Text('${friend.name}님을 삭제하시겠습니까?'),
      actions: [
        Container(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            },
            child: Text('취소', style: NotoSans.regular),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () async {
              var deleteFriendId = friend.uid;
              await instance.collection('following').doc(user!.uid).update({
                'following': FieldValue.arrayRemove([deleteFriendId])
              });
              followingList.remove(friend);
              Get.back();
            },
            child: Text('삭제', style: NotoSans.regular),
          ),
        ),
      ],
    );
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
