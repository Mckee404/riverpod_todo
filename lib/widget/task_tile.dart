import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({
    super.key,
    required this.isChecked,
    required this.taskTitle,
    required this.checkboxCallback,
    required this.longPressCallback,
  });

  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkboxCallback;
  final Function() longPressCallback;

 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.white,
      elevation: 4,
      child: GestureDetector(
        onLongPress: longPressCallback,
        child: CheckboxListTile(
          title: Text(
            taskTitle,
            style: TextStyle(
                decoration:
                    isChecked ? TextDecoration.lineThrough : null),
          ),
          value: isChecked,
          activeColor: Colors.lightBlueAccent,
          onChanged: checkboxCallback,
        ),
      ),
    );
  }
}
