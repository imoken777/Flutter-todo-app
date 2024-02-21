import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_item.dart';
import 'package:flutter_todo_app/screens/create_task_screen.dart';
import 'package:flutter_todo_app/widgets/todo_item_container.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo リスト'),
      ),
      body: Column(
        children: [
          Expanded(
            child: todoItems.isEmpty
                ? const Center(
                    child: Text(
                      'タスクがありません',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: todoItems.length,
                    itemBuilder: (context, index) {
                      return TodoItemContainer(todoItem: todoItems[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/create');
          if (result != null) {
            setState(() {
              todoItems.add(result as TodoItem);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
