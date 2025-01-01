import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task.dart';
import 'package:riverpod_todo/data/task_list.dart';

import 'package:riverpod_todo/widget/edit_dialog.dart';

class TaskTile extends ConsumerStatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.checkboxCallback,
    required this.longPressCallback,
  });
  final Task task;

  final Function(bool?) checkboxCallback;
  final Function() longPressCallback;

  @override
  ConsumerState<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isChecked = widget.task.isDone;
    final String taskTitle = widget.task.title;
    final String id = widget.task.id;
    return Material(
      color: Colors.white,
      elevation: 4,
      child: GestureDetector(
        onLongPress: widget.longPressCallback,
        child: CheckboxListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  taskTitle,
                  style: TextStyle(
                      decoration:
                          isChecked ? TextDecoration.lineThrough : null),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final String? editedText = await showDialog<String>(
                    context: context,
                    builder: (_) {
                      return EditDialog(taskTitle: taskTitle);
                    },
                  );
                  if (editedText is String) {
                    ref
                        .watch(taskListProvider.notifier)
                        .editTitle(id: id, newTitle: editedText);
                  }
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          value: isChecked,
          activeColor: Colors.lightBlueAccent,
          onChanged: widget.checkboxCallback,
        ),
      ),
    );
  }
}
