import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/utility/utility.dart';
import 'package:note_app/widget/task_item_type.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskBox = Hive.box<Task>('taskBox');

  TextEditingController controllerTaskTitle = TextEditingController();
  TextEditingController controllerTasksubtitle = TextEditingController();
  FocusNode _negahban1 = FocusNode();
  FocusNode _negahban2 = FocusNode();
  DateTime? _time;
  int _selectedTaskTypeItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _negahban1.addListener(() {
      setState(() {});
    });
    _negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    maxLength: 25,
                    controller: controllerTaskTitle,
                    focusNode: _negahban1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.symmetric(
                          horizontal: 15, vertical: 15),
                      labelText: 'عنوان',
                      labelStyle: TextStyle(
                          fontFamily: "SM",
                          fontSize: 20,
                          color: _negahban1.hasFocus
                              ? Color(0xff18DAA3)
                              : Color(0xffC5C5C5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 2.0)),
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
                    focusNode: _negahban2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.symmetric(
                          horizontal: 15, vertical: 15),
                      labelText: 'توضیحات تسک',
                      labelStyle: TextStyle(
                          fontFamily: "SM",
                          fontSize: 20,
                          color: _negahban2.hasFocus
                              ? Color(0xff18DAA3)
                              : Color(0xffC5C5C5)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 2.0),
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
              CustomHourPicker(
                elevation: 3,
                title: 'زمان تسک را انتخاب کنید',
                titleStyle: TextStyle(
                    fontFamily: 'SM', color: Colors.green, fontSize: 18),
                positiveButtonText: 'انتخاب کردن',
                positiveButtonStyle: TextStyle(
                    color: Colors.green, fontFamily: 'SM', fontSize: 18),
                onPositivePressed: (context, time) {
                  _time = time;
                },
                negativeButtonText: 'لغو کردن',
                negativeButtonStyle: TextStyle(
                    color: Colors.red, fontFamily: 'SM', fontSize: 18),
                onNegativePressed: (context) {},
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
                onPressed: () async {
                  if (_time == null) {
                    return showDialog(
                      context: context,
                      useSafeArea: false,
                      builder: (context) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                'زمان تسک انتخاب نشده !',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  String taskTitle = controllerTaskTitle.text;
                  String taskSubtitle = controllerTasksubtitle.text;

                  addTask(taskTitle, taskSubtitle);
                  Navigator.pop(context);
                },
                child: Text(
                  'اضافه کردن تسک',
                  style: TextStyle(
                      fontFamily: 'SM',
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

  addTask(String title, String subtitle) {
    var task = Task(
        title: title,
        subtitle: subtitle,
        time: _time!,
        taskType: getTaskType()[_selectedTaskTypeItem]);
    taskBox.add(task);
  }
}
