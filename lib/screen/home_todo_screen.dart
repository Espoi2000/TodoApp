import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screen/home.dart';
import 'package:todoapp/screen/task_end.dart';

import 'package:todoapp/screen/todo_insert.dart';
import 'package:todoapp/screen/todo_widget.dart';
import 'package:todoapp/utils/utils.dart';

class HomeTodoScreen extends StatefulWidget {
  const HomeTodoScreen({super.key});

  @override
  State<HomeTodoScreen> createState() => _HomeTodoScreenState();
}

class _HomeTodoScreenState extends State<HomeTodoScreen> {
  bool initialized = false;
  bool tcheked = false;
  final LocalStorage storage = LocalStorage('todo_app');

  final TodoList list = TodoList();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        var items = await storage.getItem('todos');

        // TodoList.todos = items;
        if (items != null) {
          setState(() {
            TodoList.todos = List<Todo>.from(
              (items as List).map(
                (item) => Todo(
                  intitule: item['intitule'],
                  status: item['status'],
                  hoursEndTask: item['hoursEndTask'],
                  hoursTartTask: item['hoursTartTask'],
                ),
              ),
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " le Nombre de Tache  :${TodoList.todos.length}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 201,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: TodoList.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  var task = TodoList.todos[index];
                  return TodoWidget(todo: task);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
