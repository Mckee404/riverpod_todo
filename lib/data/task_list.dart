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

  void toggleDone(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          if (task.isDone == true)
            Task(
                title: task.title,
                id: task.id,
                isDone: false,
                filter: Filter.active)
          else
            Task(
                title: task.title,
                id: task.id,
                isDone: true,
                filter: Filter.done)
        else
          task
    ];
  }

  void deleteTask(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }

  void deleteAllTasks() {
    state = [];
  }

  void deleteDoneTasks() {
    state = state.where((task) => !task.isDone).toList();
  }
}
