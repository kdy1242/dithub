
class Todo {
  bool isFinished;
  String todo;

  Todo({
    this.isFinished = false,
    required this.todo,
  });

  Map<String, dynamic> toMap() {
    return {
      'isFinished': this.isFinished,
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
