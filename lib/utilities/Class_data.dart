import 'dart:collection';
import 'package:flutter/material.dart';

import 'NewClass.dart';

class AllClassesData extends ChangeNotifier {
  final List<NewClass> _classes = [
    NewClass(name: "Maths", minAttendanceRequired: 75),
    NewClass(name: "English", minAttendanceRequired: 50),
    NewClass(name: "Hindi", minAttendanceRequired: 60),
  ];

  int classesCount() {
    return _classes.length;
  }

  UnmodifiableListView<NewClass> get classes {
    return UnmodifiableListView(_classes);
  }

  addNewClass(String titleValue, int attendance) {
    final newClass =
        NewClass(name: titleValue, minAttendanceRequired: attendance);
    _classes.add(newClass);
    notifyListeners();
  }

  void deleteClass(NewClass classToBeRemoved) {
    _classes.remove(classToBeRemoved);

    notifyListeners();
  }

  void editThisClass(
      NewClass classToBeEdited, String titleValue, int attendance) {
    int index = _classes.indexOf(classToBeEdited);

    _classes[index].minAttendanceRequired = attendance;
    _classes[index].name = titleValue;

    notifyListeners();
  }
}
