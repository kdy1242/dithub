
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
              Todo todo = Todo(todo: todoController.text);
              saveTodo(todo);
              Get.back();
            },
            child: Text('추가', style: NotoSans.regular),
          ),
        ),
      ],
    );
  }
}
