
import 'package:get/get.dart';

class Todo {
  RxBool isFinished;
  String todo;

  Todo({
    bool isFinished = false,
    required this.todo,
  }) : isFinished = isFinished.obs;

  Map<String, dynamic> toMap() {
    return {
      'isFinished': this.isFinished.value,
      'todo': this.todo,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      isFinished: map['isFinished'] as bool,
      todo: map['todo'] as String,
    );
  }
}
