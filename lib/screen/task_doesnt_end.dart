import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/screen/home.dart';
import 'package:todoapp/screen/todo_widget.dart';
import 'package:todoapp/utils/utils.dart';

class TaskDontEnd extends StatefulWidget {
  const TaskDontEnd({super.key});

  @override
  State<TaskDontEnd> createState() => _TaskDontEndState();
}

class _TaskDontEndState extends State<TaskDontEnd> {
  final LocalStorage storage = LocalStorage('todo_app');
  final TodoList list = TodoList();

  @override
  Widget build(BuildContext context) {
    var taskdoesntEnd =
        TodoList.todos.where((element) => element.status == false).toList();
    return taskdoesntEnd.isEmpty
        ? const Center(
            child: Text(
              "Aucune Tache  Non Achevés",
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        : SizedBox(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: taskdoesntEnd.length,
              itemBuilder: (BuildContext context, int index) {
                var task = taskdoesntEnd[index];
                return TodoWidget(todo: task);
              },
            ),
          );
  }
}
