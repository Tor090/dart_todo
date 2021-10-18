import 'package:flutter_task1/todo.dart';

import 'dayOfWeek.dart';

abstract class Task {
  final String? content;
  final String? category;
  final DateTime? dateTime;
  //final dayOfWeek? dayofweek;

  

  Task(this.content, this.category, this.dateTime);
}
