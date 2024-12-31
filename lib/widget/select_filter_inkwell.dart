import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task_filter.dart';

class SelectFilterInkwell extends ConsumerWidget {
  const SelectFilterInkwell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedFilter = ref.watch(filterNotifierProvider);
    // TextDecoration underLine(bool? selectedFilter, String text) {
    //   if (selectedFilter == null) {
    //     if (text == 'All') {
    //       return TextDecoration.underline;
    //     } else {
    //       return TextDecoration.none;
    //     }
    //   } else if (selectedFilter == true) {
    //     if (text == 'Done') {
    //       return TextDecoration.underline;
    //     } else {
    //       return TextDecoration.none;
    //     }
    //   } else if (selectedFilter == false) {
    //     if (text == 'Active') {
    //       return TextDecoration.underline;
    //     } else {
    //       return TextDecoration.none;
    //     }
    //   } else {
    //     return TextDecoration.none;
    //   }
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          //Todo
          //選択中のFilterに合わせてInkWellの背景変えないと選択中のフィルターが分かりづらすぎる。
          child: InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'All',
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              ref.read(filterNotifierProvider.notifier).changeFiler(null);
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
              ref.read(filterNotifierProvider.notifier).changeFiler(false);
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
              ref.read(filterNotifierProvider.notifier).changeFiler(true);
            },
          ),
        ),
      ],
    );
  }
}
