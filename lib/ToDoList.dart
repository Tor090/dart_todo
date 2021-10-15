import 'dart:io';

import 'package:flutter_task1/dayOfWeek.dart';
import 'package:flutter_task1/todo.dart';

class toDOList implements todo {
  @override
  String? content;
  @override
  String? category;
  @override
  DateTime? dateTime;
  @override
  dayOfWeek? dayofweek;

  static int Menu() {
    int m;
    do {
      print('\t1.Create todo\n\t2.Delete todo\n\t3.See all.\n\t4.Category.');
      m = int.parse(stdin.readLineSync()!);
      //print('cin $m');
      if (m < 0 || m > 4) {
        print('Даного пункту меню не iснує!');
      }
    } while (m < 0 || m > 4);
    return m;
  }

  int submenu() {
    int m;
    do {
      print('\t1.Create one todo\n\t2.Create more then one');
      m = int.parse(stdin.readLineSync()!);
      print('cin $m');
      if (m < 1 || m > 2) {
        print('Даного пункту меню не iснує!');
      }
    } while (m < 1 || m > 2);
    switch (m) {
      case 1:
        return 1;
      case 2:
        print('Count?');
        int a = int.parse(stdin.readLineSync()!);
        return a;
      default:
        print('Choosed standart value = 1');
        return 1;
    }
  }

  idtype() {
    print('Type of id: 1- number; 2 - string');
    int type = int.parse(stdin.readLineSync()!);
    if (type == 1) {
      var todos = <int, todo>{};
      return todos;
    } else if (type == 2) {
      var todos = <String, todo>{};
      return todos;
    } else {
      var todos = <int, todo>{};
      print('Input incorrect number(Selected standart type int)');
      return todos;
    }
  }

  void main() {
    var todos = idtype();
    // if (types.runtimeType == String){
    //   var todos = <String, todo>{};
    // }else{
    //   var todos = <int, todo>{};
    // }

    var menu;
    do {
      menu = Menu();
      switch (menu) {
        case 1:
          var sub = submenu();
          if (sub > 1) {
            createmany(todos, sub);
          } else {
            create(todos);
          }
          break;
        case 2:
          delete(todos);
          break;
        case 3:
          output(todos);
          break;
        case 4:
          break;
        case 0:
          break;
        default:
          print('Ви ввели помилкове значення! ');
          break;
      }
    } while (menu != 0);
  }

  void createmany<T>(Map<T, todo> todos, int count) {
    for (int i = 0; i < count; i++) {
      create(todos);
    }
  }

  void create<T>(Map<T, todo> todos) {
    T id;
    if (todos.isEmpty) {
      id = (todos.keys.runtimeType == String ? '1' : 1) as T;
    } else {
      id = ((todos.keys.runtimeType == String)
          ? (int.parse(todos.keys.last.toString()) + 1).toString()
          : int.parse(todos.keys.last.toString()) + 1) as T;
    }
    try {
      print('Insert content $id');
      var cont = stdin.readLineSync();
      if (cont != null) {
        content = cont;
      }
      print('Insert category');
      category = stdin.readLineSync();
      print('Insert date');
      dateTime = DateTime.parse(stdin.readLineSync()!);
      print('Recurring task?(1-yes/2-no)');
      var a = int.parse(stdin.readLineSync()!);
      if (a == 2) {
        dayofweek = null;
      } else {
        dayofweek = repeatmenu();
      }
    } catch (e) {
      print(e);
    }
    var temp = todo(content, category, dateTime, dayofweek);
    //print('Input acces');
    todos[id] = temp;
  }

  dayOfWeek? repeatmenu() {
    dayOfWeek? repeat;
    print(
        '1-${dayOfWeek.everyday}\n2-${dayOfWeek.everymonth}\n4-${dayOfWeek.everyweek}\n4-${dayOfWeek.everyyear}');
    var rep = int.parse(stdin.readLineSync()!);
    switch (rep) {
      case 1:
        repeat = dayOfWeek.everyday;
        break;
      case 2:
        repeat = dayOfWeek.everymonth;
        break;
      case 3:
        repeat = dayOfWeek.everyweek;
        break;
      case 4:
        repeat = dayOfWeek.everyyear;
        break;
    }
    return repeat;
  }

  @override
  void display(List<todo> dol) => print(
      'Content ${content} content category $category date $dateTime repeat $dayofweek');

  void output(Map<int, todo> todos) {
    if (todos.isNotEmpty) {
      for (var item in todos.entries) {
        print('Id = ${item.key}');
        display(todos.values.toList());
      }
    } else {
      print('Todo list is empty');
    }
  }

  void delete(Map<int, todo> todos) {
    if (todos.isNotEmpty) {
      output(todos);
      print('Delete with: 1- id\n 2 - content');
      int m = int.parse(stdin.readLineSync()!);
      var z;
      switch (m) {
        case 1:
          print('Insert id:');
          z = int.parse(stdin.readLineSync()!);
          todos.remove(m);
          break;
        case 2:
          print('Insert content:');
          z = stdin.readLineSync()!;
          todos.remove(z);
          break;
        default:
          print('Inserted value incorrect');
          break;
      }
    } else {
      print('Todo list is empty');
    }
  }
}
