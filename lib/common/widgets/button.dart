import 'package:app_task/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function? onTap;
  final String? label;

  const AppButton({
    super.key,
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
