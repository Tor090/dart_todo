import 'dart:io';
import 'package:flutter_task1/dayOfWeek.dart';
import 'package:flutter_task1/task.dart';
import 'package:flutter_task1/todo.dart';

class toDOList implements Task {
  static int Menu() {
    int m;
    do {
      print('\t1.Create todo\n\t2.Delete todo\n\t3.See all.\n\t4.Category.');
      m = int.parse(stdin.readLineSync()!);
      //print('cin $m');
      if (m < 0 || m > 4) {
        print('This menu item does not exist!');
      }
    } while (m < 0 || m > 4);
    return m;
  }

  int submenu() {
    int m;
    do {
      print('\t1.Create one todo\n\t2.Create more then one');
      m = int.parse(stdin.readLineSync()!);

      if (m < 1 || m > 2) {
        print('This menu item does not exist!');
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

  @override
  idtype() {
    print('Type of id: 1- number; 2 - string');
    try {
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
    } catch (e) {
      print(e);
    }
  }

  void main() {
    var todos = idtype();
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
          categoryes(todos);
          break;
        case 0:
          break;
        default:
          print('You entered an incorrect value! ');
          break;
      }
    } while (menu != 0);
  }

  void createmany<T>(Map<T, todo> todos, int count) {
    for (int i = 0; i < count; i++) {
      create(todos);
    }
  }

  void categoryes<T>(Map<T, todo> todos) {
    var listcat = todos.values.toList();

    Map<String?, int> newcat = {};

    for (var item in listcat) {
      if (newcat.keys.contains(item.category)) {
        newcat.update(item.category, (value) => value + 1);
      } else {
        newcat[item.category] = 1;
      }
    }

    for (var item in newcat.entries) {
      print('Category: ${item.key} repeated : ${item.value} times');
    }
  }

  void create<T>(Map<T, todo> todos) {
    T id;
    var temp;

    if (todos.isEmpty) {
      id =
          (todos.keys.runtimeType.toString().contains('String') ? '1' : 1) as T;
    } else {
      id = ((todos.keys.runtimeType.toString().contains('String'))
          ? (int.parse(todos.keys.last.toString()) + 1).toString()
          : int.parse(todos.keys.last.toString()) + 1) as T;
    }
    try {
      print('Insert content for $id todos');
      var content = stdin.readLineSync();
      print('Insert category');
      var category = stdin.readLineSync();
      print('Insert date');
      var dateTime = DateTime.parse(stdin.readLineSync()!);
      print('Recurring task?(1-yes/2-no)');
      var a = int.parse(stdin.readLineSync()!);
      var dayofweek;
      if (a == 2) {
        dayofweek = dayOfWeek.none;
      } else {
        dayofweek = repeatmenu();
      }
      temp = todo(content, category, dateTime, dayofweek);
      todos[id] = temp;
    } catch (e) {
      print(e);
    }
  }

  dayOfWeek? repeatmenu() {
    dayOfWeek? repeat;
    print(
        '1-${dayOfWeek.everyday}\n2-${dayOfWeek.everymonth}\n3-${dayOfWeek.everyweek}\n4-${dayOfWeek.everyyear}');
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

  void display(var item) {
    print(
        'Content ${item.content} Category ${item.category} Date ${item.dateTime} Repeat ${item.dayofweek.toString()}');
  }

  void output<T>(Map<T, todo> todos) {
    if (todos.isNotEmpty) {
      for (var item in todos.entries) {
        print('Id = ${item.key}');
        display(item.value);
      }
    } else {
      print('Todo list is empty');
    }
  }

  void delete<T>(Map<T, todo> todos) {
    var m;
    if (todos.isNotEmpty) {
      output(todos);
      if (todos.keys.runtimeType.toString().contains('String')) {
        print('Enter id:');
        m = stdin.readLineSync()!;
      } else {
        print('Enter id:');
        m = int.parse(stdin.readLineSync()!);
      }
      todos.remove(m);
    } else {
      print('Todo list is empty');
    }
  }
}
