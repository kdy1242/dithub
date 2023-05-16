
import 'dart:developer';

import 'package:dithub/controller/home_controller.dart';
import 'package:dithub/view/screen/home_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/fonts.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.followingList.length,
                itemBuilder: (context, index) {
                  var friend = controller.followingList[index];
                  bool isSelected = index == controller.curPage.value;

                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.onPageTapped(index);
                        log('index($index): $isSelected');
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isSelected ? Border.all(
                                color: Colors.blue, // 선택된 인덱스일 때 파란색 테두리
                                width: 2,
                              ) : null,
                            ),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.grey,
                              child: friend.profileImg == null ? Icon(Icons.person, color: Colors.white) : null,
                              backgroundImage: friend.profileImg != null
                                ? NetworkImage(friend.profileImg!)
                                : null,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(friend.name, style: NotoSans.regular.copyWith(color: isSelected ? Colors.blue : Colors.black)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.followingList.length,
                itemBuilder: (context, index) {
                  var friend = controller.followingList[index];
                  return HomeDiaryScreen(user: friend);
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}

