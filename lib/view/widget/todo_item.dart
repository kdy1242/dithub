
import 'package:flutter/material.dart';

import '../../model/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: todo.isFinished.value,
          onChanged: (value) {
            todo.isFinished.value = value!;
          },
        ),
        Text('${todo.todo}'),
      ],
    );
  }
}

