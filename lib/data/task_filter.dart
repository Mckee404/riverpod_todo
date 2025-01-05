import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_todo/data/task.dart';
import 'package:riverpod_todo/data/task_list.dart';

part 'task_filter.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  Filter build() {
    return Filter.all;
  }

  void changeFiler(Filter filter) {
    state = filter;
  }
}

List<Task> filterdList(List<Task> taskList, Filter filter) {
  switch (filter){
    case Filter.all:
      return taskList;
    case Filter.active:
      return taskList.where((task) => task.taskFilter==Filter.active).toList();
    case Filter.done:
      return taskList.where((task) => task.taskFilter==Filter.done).toList();
  }
}

@riverpod
List<Task> filteredList(Ref ref) {
  final taskList = ref.watch(taskListProvider);
  final taskFilter = ref.watch(filterNotifierProvider);

  return filterdList(taskList, taskFilter);
}