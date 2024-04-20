import 'package:flutter/material.dart';

final List<String> remindItems = <String>['10 minutes early', '30 minutes early', '1 hour early'];
final List<String> repeatItems = <String>['Weakly', 'Monthly', 'Yearly'];
final List<Color> colorItems = <Color>[Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.purple];

class Task {
  Task({
    required this.title,
    required this.deadline,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    required this.color,
    required this.isCompleted,
    required this.isFavorite,
  });
  String title;
  DateTime deadline;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String remind;
  String repeat;
  Color color;
  bool isCompleted;
  bool isFavorite;
}
