import 'package:app_task/core/helper/size_config.dart';
import 'package:app_task/core/theme/theme.dart';
import 'package:app_task/src/controller/task_controller.dart';
import 'package:app_task/src/models/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required taskController,
    required this.task,
  }) : _taskController = taskController;
  final TaskController _taskController;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, left: 20, right: 20),
      height: task.isCompleted == 1
          ? SizeConfig.screenHeight * 0.30
          : SizeConfig.screenHeight * 0.6,
      width: SizeConfig.screenWidth,
      color: Get.isDarkMode ? darkHeaderClr : Colors.white,
      child: Column(children: [
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Titre de la tâche
            Text(
              task.title,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode
                      ? Colors.white
                      : Colors.black, // Change la couleur en fonction du mode
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Heure de la tâche
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.grey[200],
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  "${task.startTime}      -      ${task.endTime}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 13,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Colors
                                .black87), // Change la couleur en fonction du mode
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description de la tâche
            Text(
              task.description,
              maxLines: 7,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode
                        ? Colors.white
                        : Colors
                            .black87), // Change la couleur en fonction du mode
              ),
            ),
          ],
        ),
        const Spacer(),
        task.isCompleted == 1
            ? Container()
            : _buildBottomSheetButton(
                label: "Tache terminée",
                onTap: () {
                  _taskController.markTaskCompleted(task.id);
                  Get.back();
                },
                clr: primaryClr),
        _buildBottomSheetButton(
            label: "Supprimer",
            onTap: () {
              _taskController.deleteTask(task);
              Get.back();
            },
            clr: Colors.red[300]),
        const SizedBox(
          height: 20,
        ),
        _buildBottomSheetButton(
            label: "Fermer",
            onTap: () {
              Get.back();
            },
            isClose: true),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  _buildBottomSheetButton(
      {required String label,
      Function? onTap,
      Color? clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth! * 0.5,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style: isClose
              ? titleTextStle
              : titleTextStle.copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
