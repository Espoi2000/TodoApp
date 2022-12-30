import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  bool isTchecked = false;
  void changeStatus(value) {
    isTchecked = value;

    notifyListeners();
  }
}
