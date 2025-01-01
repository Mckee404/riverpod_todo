import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task_list.dart';

class TaskCreateForm extends ConsumerStatefulWidget {
  const TaskCreateForm({
    super.key,
  });

  @override
  ConsumerState<TaskCreateForm> createState() => _TaskCreateFormState();
}

class _TaskCreateFormState extends ConsumerState<TaskCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _textEditingController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '値を入力してください';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter a todo title',
          suffixIcon: IconButton(
            onPressed: _textEditingController.clear,
            icon: Icon(Icons.clear),
          ),
        ),
        textAlign: TextAlign.start,
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            ref.read(taskListProvider.notifier).addTask(value);
            _textEditingController.clear();
          }
        },
      ),
    );
  }
}
