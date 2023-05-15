
import 'package:flutter/material.dart';

class FriendsFindScreen extends StatelessWidget {
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
                    decoration: InputDecoration(
                      hintText: '이메일로 검색',
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]
    );
  }
}

