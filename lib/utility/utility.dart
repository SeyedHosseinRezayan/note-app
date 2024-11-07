import 'package:note_app/data/task_type.dart';
import 'package:note_app/data/type_enum.dart';

List<TaskType> getTaskType() {
  var list = [
    TaskType(
      title: 'میدیتشن ',
      image: 'images/meditate.png',
      typeEnum: TypeEnum.focus,
    ),
    TaskType(
        title: 'ملاقات دوستانه ',
        image: 'images/social_frends.png',
        typeEnum: TypeEnum.date),
    TaskType(
        title: 'کار کردن ',
        image: 'images/hard_working.png',
        typeEnum: TypeEnum.working),
  ];
  return list;
}
