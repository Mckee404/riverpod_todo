import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_todo/data/task.dart';

part 'task_list.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  List<Task> build() => [];

  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  void deleteTask(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }

  void toggleDone(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(id: task.id, title: task.title, isDone: !task.isDone)
        else
          task
    ];
  }

  //todo
  //deleteAllとかを実装
}
