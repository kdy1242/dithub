
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/friend.dart';
import '../../util/fonts.dart';

class HomeDiaryTabItem extends StatelessWidget {
  const HomeDiaryTabItem({Key? key, required this.isSelected, required this.friend, required this.me}) : super(key: key);

  final RxBool isSelected;
  final Friend friend;
  final bool me;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected.value ? Border.all(
                color: Colors.blue,
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
          Text(friend.name, style: NotoSans.regular.copyWith(color: isSelected.value ? Colors.blue : Colors.black)),
        ],
      ),
    );
  }
}

