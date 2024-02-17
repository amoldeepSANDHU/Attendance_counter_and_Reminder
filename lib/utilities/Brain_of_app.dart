import 'package:flutter/cupertino.dart';

class RequiredValues extends ChangeNotifier {
  late String newClassTitle;

  late int minimumPercentRequired;

  void setTheValuesWhileAddingClass(String titleValue, int attendance) {
    newClassTitle = titleValue;
    minimumPercentRequired = attendance;

    notifyListeners();
  }
}
