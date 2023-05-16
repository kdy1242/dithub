
import 'package:dithub/model/diary.dart';
import 'package:dithub/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryTitleItem extends StatelessWidget {
  const DiaryTitleItem({Key? key, required this.diary}) : super(key: key);
  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Text('${DateFormat('MM/dd').format(diary.timestamp)}', style: NotoSans.bold.copyWith(color: Colors.grey)),
            )
          ),
          SizedBox(width: 8),
          Text('${diary.title}', style: NotoSans.medium.copyWith(fontSize: 16))
        ],
      ),
    );
  }
}

