import 'package:flutter/material.dart';
import 'package:flutter_todo_app/isar_instance.dart';
import 'package:flutter_todo_app/models/todo_item.dart';
import 'package:flutter_todo_app/screens/create_task_screen.dart';
import 'package:flutter_todo_app/widgets/todo_item_container.dart';
import 'package:isar/isar.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  bool showCompleted = false;

  void toggleFilter(bool value) {
    setState(() {
      showCompleted = value;
    });
  }

  Future<List<TodoItem>> getTodoItems(bool showCompleted) async {
    final todoItems = await isar.todoItems
        .filter()
        .isCompletedEqualTo(showCompleted) //完了未完了のフィルター
        .sortByDeadline()
        .findAll();
    return todoItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo リスト'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('完了済みのタスクを表示'),
              DropdownButton<bool>(
                value: showCompleted,
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    toggleFilter(newValue);
                  }
                },
                items: const [
                  DropdownMenuItem(value: false, child: Text('未完了')),
                  DropdownMenuItem(value: true, child: Text('完了'))
                ],
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            ],
          ),
          Expanded(
              child: FutureBuilder(
                  future: getTodoItems(showCompleted),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapShot.hasError) {
                      return const Center(
                        child: Text('エラーが発生しました'),
                      );
                    } else if (snapShot.hasData) {
                      final todoItems = snapShot.data as List<TodoItem>;
                      return ListView.builder(
                          itemCount: todoItems.length,
                          itemBuilder: (context, index) {
                            return TodoItemContainer(
                              todoItem: todoItems[index],
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('データがありません'),
                      );
                    }
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/create');
          if (result != null && result == true) {
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('タスクを追加しました'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
