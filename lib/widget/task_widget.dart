import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_app/screens/add_task_screen.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/screens/edit_task_screen.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isBoxChecked;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isBoxChecked = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: getMainContent(),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      children: [
        // all contents //
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: isBoxChecked,
                          onChanged: (isChecked) {
                            isChecked = isBoxChecked;
                            setState(() {});
                          }),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.task.title,
                      style: TextStyle(fontFamily: 'SM', fontSize: 15),
                    ),
                  ],
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  widget.task.subtitle,
                  style: TextStyle(fontFamily: 'SM', fontSize: 13),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 95,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              '${widget.task.time.hour}:${getMinDouble(widget.task.time)} ',
                              style: TextStyle(
                                  fontFamily: 'SM', color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'images/icon_time.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditTaskScreen(task: widget.task),
                        ));
                      },
                      child: Container(
                        width: 95,
                        height: 28,
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(13)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'ویرایش',
                                style: TextStyle(
                                    fontFamily: 'SM', color: Colors.green),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'images/icon_edit.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 20),
        // Main Image  //
        Container(
            width: 90,
            height: 90,
            child: Image.asset(widget.task.taskType.image)),
      ],
    );
  }

  String getMinDouble(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
