
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/todo.dart';
import '../util/fonts.dart';

class TodoController extends GetxController {
  TextEditingController todoController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Todo> todoList = <Todo>[].obs;

  User? get user => FirebaseAuth.instance.currentUser;
  FirebaseFirestore instance = FirebaseFirestore.instance;

  // 투두 저장
  saveTodo(Todo todo) async {
    final todoDocRef = instance.collection('todos').doc(user!.uid);
    final todoDocSnapshot = await todoDocRef.get();

    if (todoDocSnapshot.exists) {
      await todoDocRef.update({
        'todoList': FieldValue.arrayUnion([todo.toMap()]),
      });
    } else {
      await todoDocRef.set({
        'todoList': [todo.toMap()],
      });
    }
    todoList.add(todo);
  }

  // 투두 가져오기
  getTodo() async {
    var res = await instance.collection('todos').doc(user!.uid).get();
    log('${res}');
    if (res.data() != null) {
      List todoListField = res.data()!['todoList'];
      log('${todoListField}');
      for (var todo in todoListField) {
        todoList.add(Todo.fromMap(todo));
      }
    }
  }

  // 투두 완료 여부 토글
  toggleTodoStatus(int index, bool value) async {

    final todoDocRef = instance.collection('todos').doc(user!.uid);
    final todoDocSnapshot = await todoDocRef.get();

    if (todoDocSnapshot.exists) {
      var todoListField = todoDocSnapshot.data()!['todoList'];
      todoList[index].isFinished.value = value;
      todoListField[index]['isFinished'] = value;
      await todoDocRef.set({'todoList': todoListField});
    }
  }

  // 투두 삭제
  deleteTodo(int index) async {
    final todo = todoList[index];
    final todoDocRef = instance.collection('todos').doc(user!.uid);
    await todoDocRef.update({
      'todoList': FieldValue.arrayRemove([todo.toMap()]),
    });
    todoList.removeAt(index);
  }

  todoFinished() async {

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
              todoController.text = '';
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
              Todo todo = Todo(todo: todoController.text);
              saveTodo(todo);
              Get.back();
              todoController.text = '';
            },
            child: Text('추가', style: NotoSans.regular),
          ),
        ),
      ],
    );
  }

  @override
  void onInit() {
    super.onInit();

    getTodo();
  }
}
