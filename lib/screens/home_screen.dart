import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/screens/add_task_screen.dart';
import 'package:note_app/widget/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (BuildContext context, dynamic value, Widget? child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notifer) {
                  setState(() {
                    if (notifer.direction == ScrollDirection.forward) {
                      isFabVisible = true;
                    }
                    if (notifer.direction == ScrollDirection.reverse) {
                      isFabVisible = false;
                    }
                  });
                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    print(task.taskType.title);
                    return getTaskItem(task);
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          child: Image(image: AssetImage('images/icon_add.png')),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget getTaskItem(Task task) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (dismissDirection) {
          task.delete();
        },
        child: TaskWidget(task: task));
  }
}
