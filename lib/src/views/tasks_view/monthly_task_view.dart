// ignore_for_file: unused_field

import 'dart:async';
import 'package:app_task/common/widgets/custom_widget.dart';
import 'package:app_task/common/add_task_page.dart';
import 'package:app_task/common/widgets/button.dart';
import 'package:app_task/common/widgets/task_tile.dart';
import 'package:app_task/src/controller/task_controller.dart';
import 'package:app_task/core/helper/size_config.dart';
import 'package:app_task/src/models/task.dart';
import 'package:app_task/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  _MonthlyViewState createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        animate = true;
        left = 10;
        top = top / 18;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: AppButton(
        label: "+ Ajouter Task",
        onTap: () async {
          await Get.to(AddTaskPage(
            dateSelected: _selectedDate,
          ));
          _taskController.getTaskByDate(_selectedDate);
        },
      ),
      body: Column(
        children: [
          _calendarWidget(),
          const SizedBox(height: 12),
          _showTasks(),
        ],
      ),
    );
  }

  ///
  ///Methode qui permet d'afficher le calendrier
  ///et de selectionner une date afin d'afficher les tâches
  ///de cette date.
  ///

  _calendarWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TableCalendar(
        focusedDay: _selectedDate,
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: primaryClr,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: primaryClr.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          weekendTextStyle: const TextStyle(color: Colors.red),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: GoogleFonts.lato(
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
          });
          _taskController.getTaskByDate(selectedDay);
        },
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
      ),
    );
  }

  ///
  ///Methode qui permet d'afficher les tâches dans une liste animée
  ///
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
                {
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
                                  // showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              });
        }
      }),
    );
  }
}
