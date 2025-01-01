import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task_list.dart';

class DeleteTaskInkwell extends ConsumerWidget {
  const DeleteTaskInkwell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Delete Done',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            onTap: () {
              ref.read(taskListProvider.notifier).deleteDoneTasks(
                  scaffoldMessengerState: ScaffoldMessenger.of(context));
            },
          ),
        ),
        Expanded(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Delete All',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            onTap: () {
              ref.read(taskListProvider.notifier).deleteAllTasks(
                  scaffoldMessengerState: ScaffoldMessenger.of(context));
            },
          ),
        ),
      ],
    );
  }
}
