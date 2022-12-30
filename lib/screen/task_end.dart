import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/screen/home.dart';

class TaskEnd extends StatefulWidget {
  const TaskEnd({super.key});

  @override
  State<TaskEnd> createState() => _TaskEndState();
}

class _TaskEndState extends State<TaskEnd> {
  final TodoList list = TodoList();
  final LocalStorage storage = LocalStorage('todo_app');
  bool _value = false;

  var task = TodoList.todos.where((element) => element.status == true).toList();
  // var task = TodoList.todos.map((e) => e.status == true );

  @override
  Widget build(BuildContext context) {
    return task.isEmpty
        ? const Center(
            child: Text(
              "Aucune tache Achevés",
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: TodoList.todos
                  .where((element) => element.status == true)
                  .toList()
                  .length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var taskDoes = TodoList.todos
                    .where((element) => element.status == true)
                    .toList()[index];
                return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(4, 4)),
                        ]),
                    child: Row(
                      children: [
                        Checkbox(
                            value: taskDoes.status,
                            checkColor: taskDoes.status
                                ? const Color.fromARGB(
                                    255,
                                    216,
                                    19,
                                    19,
                                  )
                                : Colors.transparent,
                            onChanged: (values) {
                              setState(() {
                                taskDoes.status = !taskDoes.status;

                                _value = !_value;

                                // _toggleItem(_value, index);
                                _saveToStorage();
                              });
                            }),
                        SizedBox(
                          width: 200,
                          child: Text(
                            taskDoes.intitule,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              decoration: taskDoes.status
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }

  _saveToStorage() {
    storage.setItem('todos', list.toJSONEncodable());
  }
}
