import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.text = widget.taskTitle;
    return SimpleDialog(
      title: Text('タイトルを編集'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
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
