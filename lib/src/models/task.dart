class TaskModel {
  final int? id;
  final String title;
  final String description;
  final int? isCompleted;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String? color;
  final int? remind;
  final String? repeat;

  const TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as int?,
        title: json['title'] as String,
        description: json['description'] as String,
        isCompleted: json['isCompleted'] as int?,
        date: DateTime.parse(json['date'] as String),
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        color: json['color'] as String?,
        remind: json['remind'] as int?,
        repeat: json['repeat'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'date': date.toIso8601String(),
        'startTime': startTime,
        'endTime': endTime,
        'color': color,
        'remind': remind,
        'repeat': repeat,
      };
}
