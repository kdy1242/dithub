
import 'package:dithub/controller/friends_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/fonts.dart';

class FriendsFindScreen extends GetView<FriendsController> {
  const FriendsFindScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller.searchEmailController,
                    decoration: InputDecoration(
                      hintText: '이메일로 검색',
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    onSubmitted: (String value) {
                      controller.searchFriend();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(() => controller.searchResult.value != null
          ? ListTile(
              leading: CircleAvatar(
                radius: 36,
                backgroundImage: controller.searchResult.value!.profileImg != null
                  ? NetworkImage(controller.searchResult.value!.profileImg!)
                  : null,
              ),
              title: Text(controller.searchResult.value!.name),
              subtitle: Text(controller.searchResult.value!.email),
              trailing: Container(
                width: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0
                  ),
                  onPressed: controller.followFriend,
                  child: Text('팔로우', style: NotoSans.regular),
                ),
              ),
            )
          : Container(),
        )
      ]
    );
  }
}

