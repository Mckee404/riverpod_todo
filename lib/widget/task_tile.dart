import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  //Todo
  //longPresscallbackを追加
  const TaskTile({
    super.key,
    required this.isChecked,
    required this.taskTitle,
    required this.checkboxCallback,
  });

  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkboxCallback;
  // final Function() longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      child: CheckboxListTile(
        title: Text(
          taskTitle,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: checkboxCallback,
      ),
    );
  }
}