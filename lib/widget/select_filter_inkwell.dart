import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_todo/data/task.dart';
import 'package:riverpod_todo/data/task_filter.dart';

class SelectFilterInkwell extends ConsumerWidget {
  const SelectFilterInkwell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(filterNotifierProvider);

    Widget filterText(Filter displayFilter) {
      late final TextStyle? textStyle;
      if (displayFilter == selectedFilter) {
        textStyle = TextStyle(
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        );
      } else {
        textStyle = null;
      }

      late final String displayText;
      switch(displayFilter){
        case Filter.all:
          displayText = 'All';
        case Filter.active:
          displayText = 'Active';
        case Filter.done:
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
        filterText(Filter.all),
        filterText(Filter.active),
        filterText(Filter.done),
      ],
    );
  }
}
