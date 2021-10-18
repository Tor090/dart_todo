import 'dayOfWeek.dart';
import 'task.dart';

class RecurringTask implements Task{
  final String? content;
  final String? category;
  final DateTime? dateTime;
  final dayOfWeek? dayofweek;

  

  RecurringTask(this.content, this.category, this.dateTime, this.dayofweek);
}