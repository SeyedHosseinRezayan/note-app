import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/utility/utility.dart';
import 'package:note_app/widget/task_item_type.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var taskBox = Hive.box<Task>('taskBox');

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTasksubtitle;
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  DateTime? _time;
  int _selectedTaskTypeItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int index = getTaskType().indexWhere((taskType) {
      return taskType.typeEnum == widget.task.taskType.typeEnum;
    });
    _selectedTaskTypeItem = index;
    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTasksubtitle = TextEditingController(text: widget.task.subtitle);
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.symmetric(
                          horizontal: 15, vertical: 15),
                      labelText: 'عنوان',
                      labelStyle: TextStyle(
                          fontFamily: "SM",
                          fontSize: 20,
                          color: negahban1.hasFocus
                              ? Color(0xff18DAA3)
                              : Color(0xffC5C5C5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTasksubtitle,
                    maxLines: 2,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.symmetric(
                          horizontal: 15, vertical: 15),
                      labelText: 'توضیحات تسک',
                      labelStyle: TextStyle(
                          fontFamily: "SM",
                          fontSize: 20,
                          color: negahban2.hasFocus
                              ? Color(0xff18DAA3)
                              : Color(0xffC5C5C5)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  elevation: 3.0,
                  title: 'زمان تسک را انتخاب کنید',
                  titleStyle: TextStyle(
                      fontFamily: 'SM', color: Color(0xff18DAA3), fontSize: 18),
                  positiveButtonText: 'انتخاب کردن',
                  positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3), fontFamily: 'SM', fontSize: 18),
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  negativeButtonText: 'لغو کردن',
                  negativeButtonStyle: TextStyle(
                      color: Colors.red, fontFamily: 'SM', fontSize: 18),
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskType().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTaskTypeItem = index;
                        });
                      },
                      child: TaskItemType(
                        taskType: getTaskType()[index],
                        index: index,
                        selectedTaskTypeItem: _selectedTaskTypeItem,
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff18DAA3),
                  minimumSize: Size(200, 48),
                ),
                onPressed: () {
                  String taskTitle = controllerTaskTitle!.text;
                  String taskSubtitle = controllerTasksubtitle!.text;
                  editTask(taskTitle, taskSubtitle);
                  Navigator.pop(context);
                },
                child: Text(
                  'ویرایش کردن تسک',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  editTask(String title, String subtitle) {
    widget.task.title = title;
    widget.task.subtitle = subtitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskType()[_selectedTaskTypeItem];
    widget.task.save();
  }
}
