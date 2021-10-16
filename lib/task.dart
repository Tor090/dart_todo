import 'package:flutter_task1/todo.dart';

abstract class Task {
  void create<T>(Map<T, todo> todos);
  void output<T>(Map<T, todo> todos);
  void delete<T>(Map<T, todo> todos);
  void categoryes<T>(Map<T, todo> todos);
  idtype();
  
}
