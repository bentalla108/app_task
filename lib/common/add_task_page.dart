// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app_task/common/widgets/button.dart';
import 'package:app_task/common/widgets/input_field.dart';
import 'package:app_task/core/helper/utils.dart';
import 'package:app_task/src/controller/task_controller.dart';
import 'package:app_task/src/models/task.dart';
import 'package:app_task/core/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key, required this.dateSelected});
  final DateTime dateSelected;

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.find<TaskController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.dateSelected;
  }

  //String _startTime = DateFormat("hh:mm").format(DateTime.now());
  //_startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  // String? _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String? _endTime = "11:30 PM";
  Color _selectedColor = Colors.green.withOpacity(0.5);
  bool receiveNotification = false;

  int _selectedRemind = 5;
  List<int> remindList = [
    1,
    5,
    10,
    15,
    20,
    30,
  ];

  final String _selectedRepeat = 'None';
  // List<String> repeatList = [
  //   'None',
  //   'Daily',
  //   'Weekly',
  //   'Monthly',
  // ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, now.minute, now.second);
    final format = DateFormat.jm();
    if (kDebugMode) {
      print(format.format(dt));
      print("add Task date: ${DateFormat.yMd().format(_selectedDate)}");
    }
    //_startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ajouter une Tache",
                style: headingTextStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                title: "Titre",
                hint: "Enter title here.",
                controller: _titleController,
              ),
              InputField(
                  maxLine: 3,
                  title: "Description",
                  hint: "Description de la tache .",
                  controller: _noteController),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: (const Icon(
                    Icons.calendar_month_sharp,
                    color: Colors.grey,
                  )),
                  onPressed: () {
                    //_showDatePicker(context);
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Heure de debut",
                      hint: _startTime,
                      widget: IconButton(
                        icon: (const Icon(
                          Icons.alarm,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: "Heure de fin",
                      hint: _endTime,
                      widget: IconButton(
                        icon: (const Icon(
                          Icons.alarm,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Me rappeler :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    value: receiveNotification,
                    onChanged: (bool value) {
                      setState(() {
                        receiveNotification = value;
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: receiveNotification,
                child: InputField(
                  title: "",
                  hint: "$_selectedRemind minutes avant",
                  widget: DropdownButton<String>(
                      //value: _selectedRemind.toString(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleTextStle,
                      underline: Container(height: 0),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList()),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorChips(),
                  AppButton(
                    label: "Creer la tache",
                    onTap: () {
                      _validateInputs();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateInputs() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Attention!",
        "Veuillez remplir tous les champs.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      if (kDebugMode) {
        print("############ SOMETHING BAD HAPPENED #################");
      }
    }
  }

  ///
  ///Fonction qui permet d'ajouter une tache dans la base de données en
  ///passant par le controller.
  ///
  _addTaskToDB() async {
    await _taskController.addTask(
      task: TaskModel(
        description: _noteController.text,
        title: _titleController.text,
        date: _selectedDate,
        startTime: _startTime,
        endTime: _endTime!,
        remind: receiveNotification ? _selectedRemind : 0,
        repeat: _selectedRepeat,
        color: rgbToHex(_selectedColor),
        isCompleted: 0,
      ),
    );
  }

  ///
  ///Fonction qui permet de selectionner une couleur pour la tache
  ///Pour afficher la couleur de la tache.
  _colorChips() {
    return SizedBox(
      width: 200,
      child: ColorPicker(
        height: 30,
        width: 30,
        pickersEnabled: const {
          ColorPickerType.wheel: false,
          ColorPickerType.accent: false,
        },
        color: _selectedColor,
        onColorChanged: (Color color) {
          setState(() {
            _selectedColor = color;
          });
        },
        heading: const Text('Select color'),
        subheading: const Text('Select a different shade'),
      ),
    );
  }

  _appBar() {
    return AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
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

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    if (kDebugMode) {
      print(_pickedTime.format(context));
    }
    String? formatedTime = _pickedTime.format(context);
    if (kDebugMode) {
      print(formatedTime);
    }
    if (_pickedTime == null) {
      if (kDebugMode) {
        print("time canceld");
      }
    } else if (isStartTime)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        _startTime = formatedTime!;
      });
    else if (!isStartTime) {
      setState(() {
        _endTime = formatedTime;
      });
      //_compareTime();
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
