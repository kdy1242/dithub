
import 'package:flutter/material.dart';

import '../../model/friend.dart';
import '../../util/fonts.dart';

class HomeDiaryTabItem extends StatelessWidget {
  const HomeDiaryTabItem({Key? key, required this.isSelected, required this.friend, required this.me}) : super(key: key);

  final bool isSelected;
  final Friend friend;
  final bool me;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(me?'me':friend.name, style: NotoSans.regular.copyWith(color: isSelected ? Colors.blue : Colors.black)),
      ],
    );
  }
}

