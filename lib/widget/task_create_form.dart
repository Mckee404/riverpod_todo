import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task_list.dart';

class TaskCreateForm extends ConsumerStatefulWidget {
  const TaskCreateForm({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  ConsumerState<TaskCreateForm> createState() => _TaskCreateFormState();
}

class _TaskCreateFormState extends ConsumerState<TaskCreateForm> {
  @override
  void dispose() {
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        hintText: 'Enter a todo title',
        suffixIcon: IconButton(
          onPressed: widget.textEditingController.clear,
          icon: Icon(Icons.clear),
        ),
      ),
      textAlign: TextAlign.start,
      onSubmitted: (newText) {
        ref.read(taskListProvider.notifier).addTask(newText);
        widget.textEditingController.clear();
      },
    );
  }
}
