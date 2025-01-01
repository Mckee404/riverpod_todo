import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task.dart';
import 'package:riverpod_todo/data/task_list.dart';
import 'package:riverpod_todo/data/task_filter.dart';

import 'package:riverpod_todo/widget/task_create_form.dart';
import 'package:riverpod_todo/widget/task_tile.dart';
import 'package:riverpod_todo/widget/select_filter_inkwell.dart';
import 'package:riverpod_todo/widget/delete_task_inkwell.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Todo List',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: TaskCreateForm(),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final taskList = ref.watch(taskListProvider);
                      final processingTaskListLength =
                          filterdList(taskList, Filter.all).length;
                      return Text(
                        '$processingTaskListLength tasks left',
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(child: SelectFilterInkwell()),
                    Flexible(child: DeleteTaskInkwell()),
                  ],
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final filteredList = ref.watch(filteredListProvider);
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final task = filteredList[index];
                      return TaskTile(
                        task: task,
                        checkboxCallback: (bool? checkedValue) {
                          ref
                              .read(taskListProvider.notifier)
                              .toggleDone(task.id);
                        },
                        longPressCallback: () {
                          ref.read(taskListProvider.notifier).deleteTask(
                              target: task,
                              scaffoldMessengerState:
                                  ScaffoldMessenger.of(context));
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
