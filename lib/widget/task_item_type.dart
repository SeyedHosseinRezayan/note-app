import 'package:flutter/material.dart';
import 'package:note_app/data/task_type.dart';
import 'package:note_app/utility/utility.dart';

class TaskItemType extends StatelessWidget {
  TaskType taskType;
  int selectedTaskTypeItem;

  int index;
  TaskItemType(
      {super.key,
      required this.taskType,
      required this.selectedTaskTypeItem,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: getObject<Color>(
              object_A: Color(0xff18DAA3),
              object_B: Colors.white,
              selected: selectedTaskTypeItem,
              index: index),
          border: Border.all(
            color: getObject<Color>(
                object_A: Color(0xff18DAA3),
                object_B: const Color.fromARGB(255, 216, 216, 216),
                index: index,
                selected: selectedTaskTypeItem),
            width: getObject<double>(
                object_A: 3,
                object_B: 2,
                index: index,
                selected: selectedTaskTypeItem),
          ),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(8),
      width: 140,
      height: 80,
      child: Column(
        children: [
          Image.asset('${taskType.image}'),
          Text(
            taskType.title,
            style: TextStyle(
                fontFamily: 'SM',
                fontSize: getObject<double>(
                    object_A: 20,
                    object_B: 17,
                    selected: selectedTaskTypeItem,
                    index: index),
                color: getObject<Color>(
                    object_A: Colors.white,
                    object_B: Colors.black,
                    selected: selectedTaskTypeItem,
                    index: index)),
          )
        ],
      ),
    );
  }

  getObject<T>(
      {required T? object_A,
      required T? object_B,
      required int? selected,
      required int? index}) {
    if (selectedTaskTypeItem == index) {
      return object_A;
    } else {
      return object_B;
    }
  }
}
