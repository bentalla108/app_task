import 'package:app_task/common/widgets/custom_widget.dart';
import 'package:app_task/src/views/tasks_view/dayly_task_view.dart';
import 'package:app_task/src/views/tasks_view/monthly_task_view.dart';
import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Vue mensuelle et vue journalière
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomAppBar(),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Journalier"),
              Tab(text: "Mensuel"),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              DaylyTaskView(),
              MonthlyView(),
            ],
          ),
        ),
      ),
    );
  }
}
