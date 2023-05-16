
import 'package:dithub/model/diary.dart';
import 'package:dithub/util/fonts.dart';
import 'package:flutter/material.dart';

class DiaryDetailPage extends StatelessWidget {
  const DiaryDetailPage({Key? key, required this.diary}) : super(key: key);
  static const String route = '/diary/detail';
  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('일기'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${diary.title}', style: NotoSans.bold.copyWith(fontSize: 18)),
            SizedBox(height: 16),
            Text('${diary.content}', style: NotoSans.regular.copyWith(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

