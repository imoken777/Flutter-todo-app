import 'package:flutter_todo_app/models/todo_item.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late final Isar isar;

Future<void> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [TodoItemSchema],
    directory: dir.path,
  );
}
