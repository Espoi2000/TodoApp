// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screen/task_doesnt_end.dart';
import 'package:todoapp/screen/task_end.dart';
import 'package:todoapp/screen/todo_insert.dart';
import 'package:intl/intl.dart';

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
  // bool initialized = false;
  // bool tcheked = false;
  final LocalStorage storage = LocalStorage('todo_app');
  bool initialized = false;
  bool tcheked = false;
  // final LocalStorage storage = LocalStorage('todo_app');
  var taskId;
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: "toutes les taches "),
                  Tab(
                    text: " achevées",
                  ),
                  Tab(
                    text: " non achevées",
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
                print(TodoList.todos.length);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InsertTdodo(task: null),
                  ),
                );
              },
              child: const Icon(Icons.add),

              // floatingActionButton: FloatingActionButton(
              //   onPressed: () async {

              //   },
              //   child: const Icon(Icons.add),
              // ),
            )),
      ),
    );

    // const TabBarView(children: [
    // HomeScreen(),
    // TaskEnd(),
    // TaskDontEnd(),
    // ]),

    // ignore: dead_code
  }

  // void redUpdateTask(String task) {
  //   _editTaskController.text = task;
  //   // updateTaskSaving = _TaskController.text;
  //   updateTaskSaving = _editTaskController.text;
  // }

  // _saveToStorage() {
  //   storage.setItem('todos', list.toJSONEncodable());
  // }

  // _addItem(String title) {
  //   setState(() {
  //     final item = Todo(tache: '', tckeck: false);
  //     list.todos.insert(0, item);
  //     _saveToStorage();
  //   });
  // }

  // addTodoItem(task) {
  //   list.todos.insert(0, task);
  //   _saveToStorage();
  // }
}

class HomeTodoScreen extends StatefulWidget {
  const HomeTodoScreen({super.key});

  @override
  State<HomeTodoScreen> createState() => _HomeTodoScreenState();
}

class _HomeTodoScreenState extends State<HomeTodoScreen> {
  final TodoList list = TodoList();
  bool initialized = false;
  bool tcheked = false;
  final LocalStorage storage = LocalStorage('todo_app');
  var taskId;
  bool _value = false;
  var showDuration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
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
                dateTask: item['dateTask'],
              ),
            ),
          );
        });
      }
      print(" les data sont $items");
      // var items = json.decode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // if (!initialized) {
            //   // var items = json.decode(storage.getItem('todos'));
            //   // var decodeItems = jsonDecode(items);
            //   print("la liste des elements des $items");
            //   if (items != null) {
            //     TodoList.todos = List<Todo>.from(
            //       (items as List).map(
            //         (item) => Todo(
            //           intitule: item['intitule'],
            //           status: item['status'],
            //           hoursEndTask: item['hoursEndTask'],
            //           hoursTartTask: item['hoursTartTask'],
            //           dateTask: item['dateTask'],
            //         ),
            //       ),
            //     );
            //   }

            //   initialized = true;
            // }
            return Column(
              // horizontal).

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      " le Nombre d'élement est :${TodoList.todos.length}",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: TodoList.todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = TodoList.todos[index];

                      print(task.hoursEndTask);

                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        // height: 50,
                        // padding: const EdgeInsets.all(10),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: TodoList.todos[index].status,
                                        checkColor: TodoList.todos[index].status
                                            ? const Color.fromARGB(
                                                255,
                                                216,
                                                19,
                                                19,
                                              )
                                            : Colors.transparent,
                                        onChanged: (values) {
                                          setState(() {
                                            TodoList.todos[index].status =
                                                !TodoList.todos[index].status;

                                            _value = !_value;

                                            // _toggleItem(_value, index);
                                            TodoList.saveToStorage(list);
                                          });
                                        }),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        task.intitule,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          decoration:
                                              TodoList.todos[index].status
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InsertTdodo(
                                              task: task,
                                            ),
                                          ),
                                        );
                                        // task.tache = updateTaskSaving;

                                        // redUpdateTask(task.intitule);
                                        // task.intitule = updateTaskSaving;
                                      },
                                      child: const Icon(Icons.edit),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // durationFromTimeOfDay(
                                        //     task.hoursTartTask,
                                        //     task.hoursEndTask);

                                        // getTimeDuration(task.hoursEndTask,
                                        //     task.hoursTartTask);
                                        // String gettimeShowText = "$gettimeShow";
                                        // print(gettimeShow);

                                        var convertedtStartStask =
                                            stringToTimeOfDay(
                                                task.hoursTartTask);
                                        print(convertedtStartStask);

                                        return;
                                        _showMyDialog(task.id);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${task.dateTask}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${task.hoursTartTask}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${task.hoursEndTask}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  " la duréé est ",
                                ),
                                Text(
                                  // gettimeShowText,
                                  "const",
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showMyDialog(taskID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Voulez_vous supprimer cette tache?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                // print(task.id);
                // _clearStorage();

                setState(() {
                  TodoList.todos.removeWhere((temp) => temp.id == taskID);
                });
                TodoList.saveToStorage(list);
                // _saveToStorage();
                Navigator.pop(context);
              },
              child: const Text("ok"),
            ),
          ],
        );
      },
    );
  }

  durationTask(int hoursStart, int hoursEnd) {
    var duration = (hoursStart - hoursEnd).toInt();
    return duration;
  }

  decrementNotification(duration) {
    setState(() {
      duration;
    });
  }

  sendNotifiaction(duration) {
    if (duration == 5) {
      print("sending notification");
    }
  }

  // _clearStorage() async {
  //   await storage.clear();

  //   setState(() {
  //     TodoList.todos = storage.getItem(
  //           'todos',
  //         ) ??
  //         [];
  //   });
  // }

  // String getTimeDuration(TimeOfDay endhours, TimeOfDay startHours) {
  //   // var duration = endhours - starthours;

  //   int end = ((endhours.hour * 60 + endhours.minute) * 60);
  //   int start = (endhours.hour * 60 + endhours.minute) * 60;

  //   int duration = end - start;
  //   print(duration);
  //   String durated = "$duration";

  //   return durated;
  // }

  // String durationFromTimeOfDay(TimeOfDay? start, TimeOfDay? end) {
  //   if (start == null || end == null) return '';

  //   // DateTime(year, month, day, hour, minute)
  //   final startDT = DateTime(9, 9, 9, start.hour, start.minute);
  //   final endDT = DateTime(9, 9, 10, end.hour, end.minute);

  //   final range = DateTimeRange(start: startDT, end: endDT);
  //   final hours = range.duration.inHours % 24;
  //   final minutes = range.duration.inMinutes % 60;

  //   final _onlyHours = minutes == 0;
  //   final _onlyMinutes = hours == 0;
  //   final hourText = _onlyMinutes
  //       ? ''
  //       : '$hours${_onlyHours ? hours > 1 ? ' hours' : ' hour' : 'h'}';
  //   final minutesText = _onlyHours
  //       ? ''
  //       : '$minutes${_onlyMinutes ? minutes > 1 ? ' mins' : ' min' : 'm'}';
  //   return hourText + minutesText;
  // }

//   convertTimeOfDayToString(_startTime) {
// // TimeOfDay _startTime = TimeOfDay(hour:int.parse(string.split(":")[0]),minute: int.parse(string.split(":")[1].split(" ")[0]));
//     TimeOfDay _time = TimeOfDay(
//         hour: int.parse(string.split(":")[0]),
//         minute: int.parse(string.split(":")[1].split(" ")[0]));
//     TimeOfDay _startTime = TimeOfDay(
//         hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
//   }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
}
// endTask

// task doesn't end
