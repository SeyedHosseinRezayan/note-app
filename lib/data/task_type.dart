import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/type_enum.dart';

part 'task_type.g.dart';

@HiveType(typeId: 7)
class TaskType {
  TaskType({required this.title, required this.image, required this.typeEnum});
  @HiveField(0)
  String title;

  @HiveField(1)
  String image;

  @HiveField(2)
  TypeEnum typeEnum;
}
