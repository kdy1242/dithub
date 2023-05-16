
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/fonts.dart';

class TodoController extends GetxController {
  TextEditingController todoController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 할일 항목을 저장하는 함수
  Future<void> saveTodoItem(String uid, String todo, bool isFinished) async {
    CollectionReference todosCollection = firestore.collection('todos');

    // 해당 사용자의 문서를 가져오거나 생성합니다.
    DocumentReference userDocRef = todosCollection.doc(uid);
    DocumentSnapshot userDoc = await userDocRef.get();

    if (userDoc.exists) {
      // 기존 문서가 있을 경우 업데이트합니다.
      List<Map<String, dynamic>> todos = userDoc.get('todos');
      todos.add({
        'isFinished': isFinished,
        'todo': todo,
      });

      await userDocRef.update({'todos': todos});
    } else {
      // 새로운 문서를 생성합니다.
      List<Map<String, dynamic>> todos = [
        {
          'isFinished': isFinished,
          'todo': todo,
        }
      ];

      await userDocRef.set({'todos': todos});
    }
  }

  addTodo() {
    Get.defaultDialog(
      title: '할 일 추가하기',
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      content: TextField(
        controller: todoController,
        decoration: InputDecoration(
          labelText: '할 일을 입력하세요',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        Container(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            },
            child: Text('취소', style: NotoSans.regular),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            },
            child: Text('추가', style: NotoSans.regular),
          ),
        ),
      ],
    );
  }
}
