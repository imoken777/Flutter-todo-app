import 'package:flutter/material.dart';
import 'package:flutter_todo_app/isar_instance.dart';
import 'package:flutter_todo_app/models/todo_item.dart';
import 'package:isar/isar.dart';

class TodoItemContainer extends StatefulWidget {
  final TodoItem todoItem;

  const TodoItemContainer({
    super.key,
    required this.todoItem,
  });

  @override
  State<TodoItemContainer> createState() => _TodoItemContainerState();
}

class _TodoItemContainerState extends State<TodoItemContainer> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.todoItem.isCompleted;
  }

  void toggleTodo(Id id) async {
    await isar.writeTxn(() async {
      final todoItem = await isar.todoItems.get(id);
      if (todoItem != null) {
        todoItem.isCompleted = !todoItem.isCompleted;
        await isar.todoItems.put(todoItem);
      }
    });
    setState(() {
      isCompleted = !isCompleted;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.todoItem.isCompleted ? 'タスクを完了しました' : 'タスクを未完了にしました',
        ),
      ),
    );
  }

  void deleteTodoItem(Id id) async {
    await isar.writeTxn(() async {
      final success = await isar.todoItems.delete(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('タスクを削除しました'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleTodo(widget.todoItem.id);
      },
      child: Dismissible(
        key: Key(widget.todoItem.id.toString()),
        direction: DismissDirection.endToStart, //右から左へスワイプ
        onDismissed: (direction) {
          deleteTodoItem(widget.todoItem.id);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green // タスク完了時の色
                  : const Color.fromARGB(255, 0, 138, 197), // タスク未完了時の色
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todoItem.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  '締め切り日: ${widget.todoItem.deadline.year}/${widget.todoItem.deadline.month}/${widget.todoItem.deadline.day}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
