import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';


class EditDialog extends ConsumerStatefulWidget {
  final String taskTitle;
  const EditDialog({super.key, required this.taskTitle});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditDialogState();
}

class _EditDialogState extends ConsumerState<EditDialog> {
  TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    textEditingController.text = widget.taskTitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('タイトルを編集'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Focus(
                  onKeyEvent: (node, event) {
                    final key = event.logicalKey;
                    if (event is KeyDownEvent) {
                      if (key == LogicalKeyboardKey.tab) {
                        return textEditingController
                                .value.isComposingRangeValid
                            ? KeyEventResult.handled
                            : KeyEventResult.ignored;
                      } else {
                        return KeyEventResult.ignored;
                      }
                    } else {
                      return KeyEventResult.ignored;
                    }
                  },
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: "タイトルを入力してください",
                    ),
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context, textEditingController.text);
                      }
                    },
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '値を入力してください';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context, textEditingController.text);
                      }
                    },
                    child: Text('変更'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text('キャンセル'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
