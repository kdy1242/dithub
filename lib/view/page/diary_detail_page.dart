
import 'package:dithub/controller/diary_controller.dart';
import 'package:dithub/model/diary.dart';
import 'package:dithub/util/fonts.dart';
import 'package:dithub/view/page/diary_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryDetailPage extends GetView<DiaryController> {
  const DiaryDetailPage({Key? key, required this.diary}) : super(key: key);
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
        actions: [
          IconButton(
            onPressed: (){
              Get.off(() => DiaryEditPage(diary));
            },
            icon: Icon(Icons.edit)
          ),
          IconButton(
            onPressed: (){
              controller.deleteDiary(diary);
            },
            icon: Icon(Icons.delete)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${diary.title}', style: NotoSans.bold.copyWith(fontSize: 18)),
            SizedBox(height: 16),
            Text('${diary.content}', style: NotoSans.regular.copyWith(fontSize: 18)),
            SizedBox(height: 16),
            diary.imageUrl != null
            ? Container(
                width: 150,
                height: 150,
                color: Colors.grey[300],
                child: Image.network(diary.imageUrl!, fit: BoxFit.cover)
              )
              : Container()
          ],
        ),
      ),
    );
  }
}

