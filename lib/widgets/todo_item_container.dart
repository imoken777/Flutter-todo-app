import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_item.dart';

class TodoItemContainer extends StatelessWidget {
  const TodoItemContainer({
    super.key,
    required this.todoItem,
  });

  final TodoItem todoItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 138, 197),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
