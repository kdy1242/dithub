
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../view/screen/home_diary_screen.dart';
import '../../view/widget/home_diary_tab.dart';

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
                itemCount: controller.followingList.length + 1,
                itemBuilder: (context, index) {
                  log('index($index): ${controller.selectedIndex == index }');
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.onPageTapped(index);
                          log('index($index): ${controller.selectedIndex == index}');
                        },
                        child: HomeDiaryTabItem(isSelected: (controller.selectedIndex == index).obs, friend: controller.userToFriend, me: true,),
                      ),
                    );
                  }
                  var friend = controller.followingList[index-1];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.onPageTapped(index);
                        log('index($index): ${controller.selectedIndex == index}');
                      },
                      child: HomeDiaryTabItem(isSelected: (controller.selectedIndex == index).obs, friend: friend, me: false),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.followingList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return HomeDiaryScreen(user: controller.userToFriend, addBtnVisible: true);
                  }
                  var friend = controller.followingList[index - 1];
                  return HomeDiaryScreen(user: friend, addBtnVisible: false);
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}

