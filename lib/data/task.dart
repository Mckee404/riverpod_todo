import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Task {
  final String id;
  final String title;
  final bool isDone;

  Task({
    required this.title,
    this.isDone = false,
    String? id,
  }) :id=_uuid.v4();
}