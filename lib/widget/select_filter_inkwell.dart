import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task.dart';
import 'package:riverpod_todo/data/task_filter.dart';

class SelectFilterInkwell extends ConsumerWidget {
  const SelectFilterInkwell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(filterNotifierProvider);

    Widget filterText(Filter displayFilter, Filter selectedFilter) {
      late final textStyle;
      if (displayFilter == selectedFilter) {
        textStyle = TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        );
      } else {
        textStyle = null;
      }

      late final displayText;
      if (displayFilter == Filter.all) {
        displayText = 'All';
      } else if (displayFilter == Filter.active) {
        displayText = 'Active';
      } else if (displayFilter == Filter.done) {
        displayText = 'Done';
      }

      return Expanded(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
          onTap: () {
            ref
                .read(filterNotifierProvider.notifier)
                .changeFiler(displayFilter);
          },
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        filterText(Filter.all, selectedFilter),
        filterText(Filter.active, selectedFilter),
        filterText(Filter.done, selectedFilter),
      ],
    );
  }
}
