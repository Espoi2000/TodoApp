import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:todoapp/screen/home.dart';
import 'package:todoapp/screen/todo_widget.dart';

class TaskEnd extends StatefulWidget {
  const TaskEnd({super.key});

  @override
  State<TaskEnd> createState() => _TaskEndState();
}

class _TaskEndState extends State<TaskEnd> {
  final LocalStorage storage = LocalStorage('todo_app');

  // var task = TodoList.todos.map((e) => e.status == true );

  @override
  Widget build(BuildContext context) {
    var taskEnd =
        TodoList.todos.where((element) => element.status == true).toList();
    return taskEnd.isEmpty
        ? const Center(
            child: Text(
              "Aucune tache Achevée",
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : SizedBox(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskEnd.length,
              itemBuilder: (BuildContext context, int index) {
                var task = taskEnd[index];
                return TodoWidget(todo: task);
              },
            ),
          );
  }
}
