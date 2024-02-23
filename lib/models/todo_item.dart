import 'package:isar/isar.dart';

part 'todo_item.g.dart';

@Collection()
class TodoItem {
  Id id = Isar.autoIncrement;
  String title = 'default title';
  bool isCompleted = false;
}
