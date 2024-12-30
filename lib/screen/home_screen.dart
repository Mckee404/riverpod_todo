import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task_list.dart';

import 'package:riverpod_todo/widget/task_create_form.dart';
import 'package:riverpod_todo/widget/task_tile.dart';
import 'package:riverpod_todo/data/task_filter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  //Todo
  //snackbarは本質じゃないくせにだるそうだから飛ばす
  //いつかやる

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredList = ref.watch(filterdListProvider);
    final TextEditingController textEditingController =
        TextEditingController(text: '');

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
                    child: TaskCreateForm(
                      textEditingController: textEditingController,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '? tasks left',
                  ),
                ),
                //Todo
                //filterを操作するところだけ別のファイルに切り出したい。
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'All',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          ref
                              .read(filterNotifierProvider.notifier)
                              .changeFiler(Filter.all);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Active',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          ref
                              .read(filterNotifierProvider.notifier)
                              .changeFiler(Filter.active);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Done',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          ref
                              .read(filterNotifierProvider.notifier)
                              .changeFiler(Filter.done);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final task = filteredList[index];
                  return TaskTile(
                    isChecked: task.isDone,
                    taskTitle: task.title,
                    checkboxCallback: (bool? checkedValue) {
                      ref.read(taskListProvider.notifier).toggleDone(task.id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
