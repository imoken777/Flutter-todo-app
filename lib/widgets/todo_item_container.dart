import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_item.dart';

class TodoItemContainer extends StatefulWidget {
  final TodoItem todoItem;
  final VoidCallback onDelete;

  const TodoItemContainer({
    super.key,
    required this.todoItem,
    required this.onDelete,
  });

  @override
  State<TodoItemContainer> createState() => _TodoItemContainerState();
}

class _TodoItemContainerState extends State<TodoItemContainer> {
  void _toggleTodo() {
    setState(() {
      widget.todoItem.isCompleted = !widget.todoItem.isCompleted;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.todoItem.isCompleted ? 'タスクを完了しました' : 'タスクを未完了にしました',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTodo,
      child: Dismissible(
        key: Key(widget.todoItem.id),
        direction: DismissDirection.endToStart, //右から左へスワイプ
        onDismissed: (direction) {
          widget.onDelete();
        },
        background: Container(
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
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
              color: widget.todoItem.isCompleted
                  ? Colors.green // タスク完了時の色
                  : Color.fromARGB(255, 0, 138, 197), // タスク未完了時の色
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
                    decoration: widget.todoItem.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
