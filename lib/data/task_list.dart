import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_todo/data/task.dart';

part 'task_list.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  List<Task> build() => [];

  void editTitle({required String id, required String newTitle}) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
              title: newTitle,
              id: task.id,
              isDone: task.isDone,
              filter: task.taskFilter)
        else
          task
    ];
  }

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

  void deleteTask(
      {required Task target,
      required ScaffoldMessengerState scaffoldMessengerState}) {
    final previousState = state;
    final String targetTitle = target.title;
    state = state.where((task) => task.id != target.id).toList();
    scaffoldMessengerState.removeCurrentSnackBar();
    scaffoldMessengerState.showSnackBar(
      SnackBar(
        content: Text('タスク"$targetTitle"を削除しました。'),
        action: SnackBarAction(
          label: 'キャンセル',
          onPressed: () {
            state = previousState;
            scaffoldMessengerState.removeCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void deleteAllTasks(
      {required ScaffoldMessengerState scaffoldMessengerState}) {
    if (state.isNotEmpty) {
      final previousState = state;
      state = [];
      scaffoldMessengerState.removeCurrentSnackBar();
      scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text('全てのタスクを削除しました。'),
          action: SnackBarAction(
            label: 'キャンセル',
            onPressed: () {
              state = previousState;
              scaffoldMessengerState.removeCurrentSnackBar();
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void deleteDoneTasks(
      {required ScaffoldMessengerState scaffoldMessengerState}) {
    final doneTaskList = state.where((task) => task.isDone).toList();
    final notDoneTaskList = state.where((task) => !task.isDone).toList();
    if (doneTaskList.isNotEmpty) {
      final previousState = state;
      state = notDoneTaskList;
      scaffoldMessengerState.removeCurrentSnackBar();
      scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text('完了済みのタスクを全て削除しました。'),
          action: SnackBarAction(
            label: 'キャンセル',
            onPressed: () {
              state = previousState;
              scaffoldMessengerState.removeCurrentSnackBar();
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
