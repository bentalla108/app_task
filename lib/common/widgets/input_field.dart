import 'package:app_task/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? widget;
  final int? maxLine;

  const InputField(
      {super.key,
      required this.title,
      this.controller,
      required this.hint,
      this.widget,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleTextStle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              // padding: const EdgeInsets.only(left: 14.0),
              // height: 52,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: TextFormField(
                autofocus: false,
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                readOnly: widget == null ? false : true,
                controller: controller,
                style: subTitleTextStle,
                maxLines: maxLine,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 14.0),
                  suffixIcon: widget == null ? const SizedBox() : widget!,
                  hintText: hint,
                  hintStyle: subTitleTextStle,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
