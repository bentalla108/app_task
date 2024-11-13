import 'package:app_task/core/services/theme_services.dart';
import 'package:app_task/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget noTaskMsg(double left, double top) {
  return Stack(
    children: [
      AnimatedPositioned(
        duration: const Duration(milliseconds: 2000),
        left: left,
        top: top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "images/task.svg",
              // ignore: deprecated_member_use
              color: primaryClr.withOpacity(0.5),
              height: 90,
              semanticsLabel: 'Task',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Vous n'avez pas encore de tâches!\nAjoutez de nouvelles tâches pour \nrendre vos journées productives.",
                textAlign: TextAlign.center,
                style: subTitleTextStle,
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      )
    ],
  );
}

// CustomAppBar() {
//   return
// }

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            setState(() {});
          },
          child: Icon(!Get.isDarkMode ? Icons.wb_sunny : Icons.shield_moon,
              color: !Get.isDarkMode ? Colors.amber : Colors.black),
        ),
        actions: const [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage("images/girl.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
        ]);
  }
}
