import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_item.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TodoItem todoItem;
  late TextEditingController _todoInputController;

  void initState() {
    super.initState();
    _todoInputController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    _todoInputController.dispose();
  }

  void _createTodo() {
    if (_todoInputController.text.length > 0) {
      todoItem = TodoItem(
          id: UniqueKey().toString(),
          title: _todoInputController.text,
          isCompleted: false);
    }
    _todoInputController.clear();
    Navigator.of(context).pop(todoItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク新規作成'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
          ),
          TextField(
            controller: _todoInputController,
            autofocus: true,
            onEditingComplete: _createTodo,
            style: const TextStyle(fontSize: 18, color: Colors.black),
            decoration: const InputDecoration(
              labelText: 'タスク名',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _createTodo,
            child: const Text('タスク作成'),
          ),
        ],
      ),
    );
  }
}
