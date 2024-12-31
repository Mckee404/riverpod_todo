import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_todo/data/task.dart';
import 'package:riverpod_todo/data/task_list.dart';

part 'task_filter.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  bool? build() {
    return null;
  }

  void changeFiler(bool? filter) {
    state = filter;
  }
}

List<Task> filterdList(List<Task> taskList, bool? isDone) {
  if (isDone == null) {
    return taskList;
  } else if (isDone == true) {
    return taskList.where((task) => task.isDone).toList();
  } else {
    return taskList.where((task) => !task.isDone).toList();
  }
}

@riverpod
List<Task> filteredList(Ref ref) {
  final taskList = ref.watch(taskListProvider);
  final taskFilter = ref.watch(filterNotifierProvider);

  return filterdList(taskList, taskFilter);
}