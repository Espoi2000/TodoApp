// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screen/home_todo_screen.dart';
import 'package:todoapp/screen/task_doesnt_end.dart';
import 'package:todoapp/screen/task_end.dart';
import 'package:todoapp/screen/todo_insert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.list,
  });
  final list;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class TodoList {
  static List<Todo> todos = [];

  toJSONEncodable() {
    return todos.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }

  static saveToStorage(data) {
    final LocalStorage storage = LocalStorage('todo_app');
    storage.setItem('todos', data.toJSONEncodable());
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage storage = LocalStorage('todo_app');
  bool initialized = false;
  bool tcheked = false;
  var notification =
      TodoList.todos.where((element) => element.status == true).toList().length;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Les Taches "),
                Tab(
                  text: " Achevées",
                ),
                Tab(
                  text: " Non Achevées",
                ),
              ],
            ),
            title: const Text('My BLoc'),
          ),
          body: const TabBarView(
            children: [
              HomeTodoScreen(),
              TaskEnd(),
              TaskDontEnd(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InsertTdodo(task: null),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
