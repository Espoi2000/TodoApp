import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageManagement extends ChangeNotifier {
  static dynamic getStorageItem(key) async {
    var data = await LocalStorage('todos').getItem(key);
    return data;
  }

  static void saveStorageItem(key, item) {
    LocalStorage('todos').setItem(key, item);
  }
}
