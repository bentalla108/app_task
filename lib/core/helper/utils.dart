import 'dart:ui';

import 'package:intl/intl.dart';

Color strengthenColor(Color color, double factor) {
  int r = (color.red * factor).clamp(0, 255).toInt();
  int g = (color.green * factor).clamp(0, 255).toInt();
  int b = (color.blue * factor).clamp(0, 255).toInt();
  return Color.fromARGB(color.alpha, r, g, b);
}

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

String getTimeFromDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

List<DateTime> generateMonthDates(int monthOffset) {
  final now = DateTime.now();
  final firstDayOfMonth = DateTime(now.year, now.month + monthOffset, 1);
  final daysInMonth =
      DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0).day;

  return List.generate(
      daysInMonth, (index) => firstDayOfMonth.add(Duration(days: index)));
}

String convertTimeFormat(String time12Hour) {
  // Convertir l'heure 12-hour avec AM/PM au format DateTime
  final DateTime dateTime = DateFormat.Hm().parse(time12Hour);

  // Convertir au format 24-hour sans AM/PM
  return DateFormat("HH:mm").format(dateTime);
}
