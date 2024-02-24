import 'package:flutter/material.dart';
import 'package:flutter_todo_app/isar_instance.dart';
import 'package:flutter_todo_app/models/todo_item.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TodoItem todoItem;
  late TextEditingController _todoInputController;

  late DateTime _inputDate;

  @override
  void initState() {
    super.initState();
    _todoInputController = TextEditingController();
  }

  @override
  void dispose() {
    _todoInputController.dispose();
    super.dispose();
  }

  void _createTodo() async {
    if (_todoInputController.text.isNotEmpty) {
      final newTodo = TodoItem()
        ..title = _todoInputController.text
        ..deadline = _inputDate
        ..isCompleted = false;

      await isar.writeTxn(() async {
        await isar.todoItems.put(newTodo);
      });
    }
    _todoInputController.clear();
    Navigator.of(context).pop(true);
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
          OutlinedButton(
              onPressed: () => _openInputDateField(context),
              child: const Text('締め切り日付選択')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _createTodo,
            child: const Text('タスク作成'),
          ),
        ],
      ),
    );
  }

  Future<void> _openInputDateField(BuildContext context) async {
    final DateTime? _date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());
    if (_date != null) {
      setState(() {
        _inputDate = _date;
      });
    }
  }
}
