import 'package:isar/isar.dart';

part 'todo_item.g.dart';

@Collection()
class TodoItem {
  Id id = Isar.autoIncrement;

  String title = 'default title';

  @Index()
  DateTime deadline = DateTime.now();

  bool isCompleted = false;
}
