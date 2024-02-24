import 'package:flutter/material.dart';
import 'package:flutter_todo_app/isar_instance.dart';
import 'package:flutter_todo_app/screens/create_task_screen.dart';
import 'package:flutter_todo_app/screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeIsar();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Hiragino Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 0, 138, 197),
        ),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TodoListScreen(),
        '/create': (context) => const CreateTaskScreen(),
      },
    );
  }
}
