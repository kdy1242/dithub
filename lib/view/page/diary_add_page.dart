
import 'package:dithub/controller/diary_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../util/fonts.dart';

class DiaryAddPage extends GetView<DiaryController> {
  const DiaryAddPage({Key? key}) : super(key: key);
  static const String route = '/diary/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('일기 작성', style: NotoSans.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('${DateFormat('yyyy / MM / dd').format(DateTime.now())}', style: NotoSans.regular.copyWith(fontSize: 22, color: Colors.grey),),
                ),
                TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                    hintStyle: NotoSans.regular.copyWith(fontSize: 20),
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                TextField(
                  controller: controller.contentsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '${FirebaseAuth.instance.currentUser!.displayName}님의 하루는 어땠나요?',
                    hintStyle: NotoSans.regular.copyWith(fontSize: 18),
                    border: InputBorder.none,
                  ),
                ),
                Spacer(),
                Obx(
                  () => GestureDetector(
                    onTap: controller.addImage,
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[300],
                      child: controller.selectedImage.value != null
                          ? Image.file(controller.selectedImage.value!, fit: BoxFit.cover)
                          : null,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0
                    ),
                    onPressed: () {
                      controller.addDiary();
                    },
                    child: Text('등록하기', style: NotoSans.regular),
                  ),
                ),
                SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

