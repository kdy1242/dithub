
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/diary.dart';
import '../util/app_routes.dart';

class DiaryController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxList<Diary> diaryList = <Diary>[].obs;
  Rxn<File> selectedImage = Rxn();
  var imageUrl;

  User? get user => FirebaseAuth.instance.currentUser;
  FirebaseFirestore instance = FirebaseFirestore.instance;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  onTapAddDiaryBtn() {
    Get.toNamed(AppRoutes.addDiary);
  }

  // 이미지 선택
  addImage() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      selectedImage(File(res.path));
    }
  }

  // 다이어리 추가
  addDiary() async {
    DateTime currentDate = DateTime.now();

    String formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";

    final diaryQuery = instance
        .collection('diary')
        .doc(user!.uid)
        .collection('diaryList')
        .where('timestamp', isGreaterThanOrEqualTo: formattedDate)
        .where('timestamp', isLessThan: formattedDate + 'T23:59:59');

    final diaryQuerySnapshot = await diaryQuery.get();

    if (diaryQuerySnapshot.docs.isNotEmpty) {
      print('오늘 일기 이미 썻음');
      return;
    }

    if (selectedImage.value != null) {
      var ref = FirebaseStorage.instance.ref('diary/${user!.uid}/${currentDate}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      imageUrl = downloadUrl;
    }

    String diaryId = FirebaseFirestore.instance.collection('diary').doc().id;

    Diary diary = Diary(
      id: diaryId,
      uid: user!.uid,
      title: titleController.text,
      content: contentsController.text,
      timestamp: currentDate,
      imageUrl: imageUrl,
    );

    final diaryDocRef = instance.collection('diary').doc(user!.uid);
    final diaryDocSnapshot = await diaryDocRef.get();

    if (diaryDocSnapshot.exists) {
      await diaryDocRef.update({
        'diaryList': FieldValue.arrayUnion([diary.toMap()])
      });
    } else {
      await diaryDocRef.set({
        'diaryList': [diary.toMap()]
      });
    }

    diaryList.add(diary);
    Get.back();
    titleController.text = '';
    contentsController.text = '';
    selectedImage(null);
  }

  // 다이어리 삭제
  deleteDiary(Diary diary) async {
    final diaryDocRef = instance.collection('diary').doc(user!.uid);
    final diaryDocSnapshot = await diaryDocRef.get();

    if (diaryDocSnapshot.exists) {
      await diaryDocRef.update({
        'diaryList': FieldValue.arrayRemove([diary.toMap()])
      });
    }

    // 이미지가 있는 경우 해당 이미지도 삭제
    if (diary.imageUrl != null) {
      var ref = FirebaseStorage.instance.refFromURL(diary.imageUrl!);
      await ref.delete();
    }

    diaryList.remove(diary);
    Get.back();
  }

  // 다이어리 수정
  updateDiary(Diary diary, String newTitle, String newContent, File? newImage) async {
    final diaryDocRef = instance.collection('diary').doc(user!.uid);
    final diaryDocSnapshot = await diaryDocRef.get();

    if (diaryDocSnapshot.exists) {
      var diaryList = diaryDocSnapshot.data()?['diaryList'];
      if (diaryList != null) {
        List<dynamic> updatedDiaryList = List.from(diaryList);
        int diaryIndex = updatedDiaryList.indexWhere((item) => item['id'] == diary.id);

        if (diaryIndex != -1) {
          if (newImage != null) {
            // 기존 이미지 삭제
            if (diary.imageUrl != null) {
              await FirebaseStorage.instance.refFromURL(diary.imageUrl!).delete();
            }

            // 새 이미지 업로드
            var ref = FirebaseStorage.instance.ref('diary/${user!.uid}/${diary.timestamp}');
            await ref.putFile(newImage);
            var downloadUrl = await ref.getDownloadURL();
            diary.imageUrl = downloadUrl;
            updatedDiaryList[diaryIndex]['imageUrl'] = downloadUrl;
          }

          // 제목과 내용 업데이트
          updatedDiaryList[diaryIndex]['title'] = newTitle;
          updatedDiaryList[diaryIndex]['content'] = newContent;

          await diaryDocRef.update({
            'diaryList': updatedDiaryList,
          });

          diary.title = newTitle;
          diary.content = newContent;

          // 다이어리 리스트 갱신
          diaryList.refresh();
          Get.offAllNamed(AppRoutes.main);
        }
      }
    }
  }

  // 다이어리 가져오기
  getDiary() async {
    var res = await instance.collection('diary').doc(user!.uid).get();
    if (res.data() != null) {
      List<dynamic> diaryListField = res.data()!['diaryList'];
      List<Diary> sortedDiaryList = diaryListField
        .map((diary) => Diary.fromMap(diary))
        .toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

      diaryList.value = sortedDiaryList;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getDiary();
  }
}
