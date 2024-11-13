// ignore_for_file: unused_field

import 'dart:async';

import 'package:app_task/common/add_task_page.dart';
import 'package:app_task/common/widgets/bottom_sheet.dart';
import 'package:app_task/common/widgets/button.dart';
import 'package:app_task/common/widgets/custom_widget.dart';
import 'package:app_task/common/widgets/task_tile.dart';
import 'package:app_task/src/controller/task_controller.dart';
import 'package:app_task/core/helper/size_config.dart';
import 'package:app_task/src/models/task.dart';
import 'package:app_task/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DaylyTaskView extends StatefulWidget {
  const DaylyTaskView({super.key});

  @override
  _DaylyTaskViewState createState() => _DaylyTaskViewState();
}

class _DaylyTaskViewState extends State<DaylyTaskView> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  final _taskController = Get.put(TaskController());
  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _taskController.getTaskByDate(_selectedDate);
    _timer = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        animate = true;
        left = 10;
        top = top / 8;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: AppButton(
        label: "+ Add Task",
        onTap: () async {
          await Get.to(AddTaskPage(
            dateSelected: _selectedDate,
          ));
          _taskController.getTaskByDate(
            _selectedDate,
          );
        },
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _dateBar(),
          const SizedBox(
            height: 12,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: DatePicker(
          DateTime.now(),
          height: 100.0,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          //selectedTextColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
          ),

          onDateChange: (date) {
            setState(
              () {
                _selectedDate = date;
                _taskController.getTaskByDate(
                  _selectedDate,
                );
              },
            );
          },
        ),
      ),
    );
  }

  ///
  /// Fonction pour ajouter la barre des tâches
  /// Cette barre contient la date et le titre de la page
  /// Aujourd'hui
  ///
  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Aujourd'hui",
                style: headingTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///Fonction pour afficher les tâches
  ///En utilisant Obx pour observer les changements dans la liste des tâches
  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return noTaskMsg(left, top);
        } else {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                TaskModel task = _taskController.taskList[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1375),
                  child: SlideAnimation(
                    horizontalOffset: 300.0,
                    child: FadeInAnimation(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.bottomSheet(CustomBottomSheet(
                                  task: task,
                                  taskController: _taskController,
                                ));
                              },
                              child: TaskTile(task)),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}
