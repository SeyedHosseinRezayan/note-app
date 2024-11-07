import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task_type.dart';
import 'package:note_app/data/type_enum.dart';

import 'package:note_app/data/task.dart';
import 'package:note_app/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TypeEnum>(TypeEnumAdapter());
  Hive.registerAdapter<TaskType>(TaskTypeAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'SM',
            fontSize: 16,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
