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
  if (filter == Filter.all) {
    return taskList;
  } else if (filter == Filter.active) {
    return taskList.where((task) => !task.isDone).toList();
  } else if (filter == Filter.done){
    return taskList.where((task) => task.isDone).toList();
  } else {
    print("error(task_filter.dart)");
    return taskList;
  }
}

@riverpod
List<Task> filteredList(Ref ref) {
  final taskList = ref.watch(taskListProvider);
  final taskFilter = ref.watch(filterNotifierProvider);

  return filterdList(taskList, taskFilter);
}