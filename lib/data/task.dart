import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task_type.dart';
part 'task.g.dart';

@HiveType(typeId: 5)
class Task extends HiveObject {
  Task(
      {required this.title,
      required this.subtitle,
      this.isBoxChecked = false,
      required this.time,
      required this.taskType});

  @HiveField(0)
  String title;

  @HiveField(1)
  String subtitle;

  @HiveField(2)
  bool isBoxChecked;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;
}
