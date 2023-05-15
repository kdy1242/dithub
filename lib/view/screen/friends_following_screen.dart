
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/friends_controller.dart';
import '../../util/fonts.dart';

class FriendsFollowingScreen extends GetView<FriendsController> {
  const FriendsFollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.followingList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 36,
              backgroundColor: Colors.grey,
              child: controller.followingList[index].profileImg == null ? Icon(Icons.person, color: Colors.white) : null,
              backgroundImage: controller.followingList[index].profileImg != null
                ? NetworkImage(controller.followingList[index].profileImg!)
                : null,
            ),
            title: Text(controller.followingList[index].name),
            subtitle: Text(controller.followingList[index].email),
            trailing: Container(
              width: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0
                ),
                onPressed: () {
                  controller.onTapDeleteBtn(controller.followingList[index]);
                },
                child: Text('삭제', style: NotoSans.regular),
              ),
            ),
          );
        }
      ),
    );
  }
}

