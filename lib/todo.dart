import 'package:flutter_task1/dayOfWeek.dart';
import 'package:flutter_task1/task.dart';

class todo implements Task{
  final String? content;
  final String? category;
  final DateTime? dateTime;
  //final dayOfWeek? dayofweek;

  

  todo(this.content, this.category, this.dateTime);
}
