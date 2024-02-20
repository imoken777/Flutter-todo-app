import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String taskTitle = '';

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
            style: const TextStyle(fontSize: 18, color: Colors.black),
            decoration: const InputDecoration(
              labelText: 'タスク名',
            ),
            onSubmitted: (String value) {
              setState(() {
                taskTitle = value;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('タスク作成'),
          ),
        ],
      ),
    );
  }
}
