import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task_list.dart';

class TaskCreateForm extends ConsumerWidget {
  const TaskCreateForm({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: 'Enter a todo title',
        suffixIcon: IconButton(
          onPressed: textEditingController.clear,
          icon: Icon(Icons.clear),
        ),
      ),
      textAlign: TextAlign.start,
      onSubmitted: (newText) {
        ref.watch(taskListProvider.notifier).addTask(newText);
        textEditingController.clear();
      },
    );
  }
}
