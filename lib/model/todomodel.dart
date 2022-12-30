import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Todo {
  String intitule;
  bool status;
  dynamic dateTask;
  dynamic hoursTartTask;
  dynamic hoursEndTask;

  int? id;
  Todo({
    required this.intitule,
    required this.status,
    required this.dateTask,
    required this.hoursTartTask,
    required this.hoursEndTask,
    this.id,
  }) {
    id = DateTime.now().microsecondsSinceEpoch;
  }

  // factory Todo.fromJson(Map<String, dynamic> jsonData) {
  //   return Todo(
  //     intitule: jsonData["intitule"],
  //     status: false,
  //     dateTask: jsonData["dateTask"] == null
  //         ? null
  //         : DateTime.parse(jsonData["dateTask"]),
  //     hoursTartTask: jsonData["hoursTartTask"] == null
  //         ? null
  //         : DateTime.parse(jsonData["hoursTartTask"]),
  //     hoursEndTask: jsonData["hoursEndTask"] == null
  //         ? null
  //         : DateTime.parse(
  //             jsonData["hoursEndTask"],
  //           ),
  //   );
  // }

  toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['intitule'] = intitule;
    m['status'] = status;
    m['dateTask'] = dateTask;
    m['hoursTartTask'] = hoursTartTask;
    m['hoursEndTask'] = hoursEndTask;

    return m;
  }
}
