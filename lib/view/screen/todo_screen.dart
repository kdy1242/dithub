
import 'package:dithub/controller/todo_controller.dart';
import 'package:dithub/view/widget/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/fonts.dart';

class TodoScreen extends GetView<TodoController> {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Todo List', style: NotoSans.bold.copyWith(fontSize: 28)),
            Text('할 일을 관리해 보세요!', style: NotoSans.regular.copyWith(fontSize: 16)),
            SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  Obx(
                    () => ListView.builder(
                      itemCount: controller.todoList.length,
                      itemBuilder: (context, index) {
                        var todo = controller.todoList[index];
                        return GestureDetector(
                          onLongPress: () {
                            controller.deleteTodo(index);
                          },
                          onTap: () {
                            controller.toggleTodoStatus(index, !todo.isFinished.value);
                          },
                          child: TodoItem(todo: todo)
                        );
                      }
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: controller.addTodo,
                      child: Container(
                        width: 48,
                        height: 48,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
