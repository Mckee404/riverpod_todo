import 'package:uuid/uuid.dart';

var _uuid = Uuid();

enum Filter {
  active,
  done,
  all,
}

class Task {
  final String id;
  final String title;
  final Filter taskFilter;

  Task({
    required this.title,
    String? id,
    Filter? filter,
  })  : id = id ?? _uuid.v4(),
        taskFilter = filter ?? Filter.active;
}
