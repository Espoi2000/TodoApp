import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';

import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screen/home.dart';
import 'package:todoapp/utils/utils.dart';

import 'package:intl/intl.dart';

class InsertTdodo extends StatefulWidget {
  const InsertTdodo({super.key, this.task});
  final task;
  @override
  State<InsertTdodo> createState() => _InsertTdodoState();
}

class _InsertTdodoState extends State<InsertTdodo> {
  final LocalStorage storage = LocalStorage('todo_app');
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateTaskController = TextEditingController();
  final TextEditingController _starthoursController = TextEditingController();
  final TextEditingController _endHoursController = TextEditingController();

  bool tcheked = false;
  var updateTaskSaving = "";
  String taskvalue = "";
  String lastvalue = "";
  String newValeu = "";
  final _formKey = GlobalKey<FormState>();
  TodoList list = TodoList();
  dynamic starthours;
  dynamic endhours;
  dynamic dateValue;

  @override
  Widget build(BuildContext context) {
    if (widget.task != null) {
      _taskController.text = widget.task.intitule;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Utils().titleForm(
                context,
                'Veuillez Saisir vos Tâches',
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _taskController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return "veuillez entrer une tache de length >= 10";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 20),
                            fillColor: const Color.fromRGBO(217, 217, 217, 0.4),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 0.5),
                              fontSize: 13,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "entrer le libellé de la tache",
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _dateTaskController,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "veuillez entrer une date";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 20),
                            fillColor: const Color.fromRGBO(217, 217, 217, 0.4),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 0.5),
                              fontSize: 13,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Entrer la date de la tache",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                dateValue = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                );
                                // print(_birthDay);

                                if (dateValue != null) {
                                  setState(() {
                                    DateTime now = DateTime.now();
                                    dateValue = DateFormat('dd / MM / yyyy')
                                        .format(now)
                                        .toString();

                                    _dateTaskController.text = dateValue;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.red,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            )),
                      ),
                      // choix des heures

                      // choix des heures
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _starthoursController,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "veuillez entrer l'heure de debut";
                          }
                          // if (starthours.compareTo(endhours) > 0) {
                          //   return "l'heure de debut doit être supérieure a l'heure de fin ";
                          // }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 20),
                            fillColor: const Color.fromRGBO(217, 217, 217, 0.4),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 0.5),
                              fontSize: 13,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Entrer la l'heure de début",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                starthours = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (starthours != null) {
                                  setState(() {
                                    // DateTime now =
                                    //     DateFormat.jm().parse(convertedTime);
                                    // starthours =
                                    //     DateFormat("HH:mm").format(now);
                                    // _dateTaskController.text = starthours;

                                    // _starthoursController.text =
                                    //     "${starthours.hour}:${starthours.minute}";
                                    _starthoursController.text =
                                        "${starthours.hour}:${starthours.minute}";
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.red,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _endHoursController,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "veuillez entrer l'heure de fin";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.only(left: 20),
                            fillColor: const Color.fromRGBO(217, 217, 217, 0.4),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 0.5),
                              fontSize: 13,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Entrer la l'heure de fin",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                endhours = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (endhours != null) {
                                  print(endhours);
                                  // var text =
                                  //     "${endhours.hour}:${endhours.minute}";

                                  // DateTime parserdTime = DateFormat.jm()
                                  //     .parse(endhours.toString());
                                  // endhours =
                                  //     DateFormat('HH:mm:ss').parse(endhours);
                                  // print(endhours.runtimeType);
                                  // print(endhours);
                                  setState(() {
                                    _endHoursController.text =
                                        "${endhours.hour}:${endhours.minute}";
                                    // DateTime now = DateFormat.jm()
                                    //     .parse(_endHoursController.text);
                                    // endhours = DateFormat("HH:mm").format(now);
                                    // _endHoursController.text =
                                    //     _endHoursController.text;
                                  });
                                  print(endhours.runtimeType);
                                }
                              },
                              icon: const Icon(
                                Icons.alarm,
                                color: Colors.red,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          taskvalue = _taskController.text;
                          // print(endhours.runtimeType);
                          // var stringged = "${endhours.hour}:${endhours.minute}";
                          // print("converted: $stringged");
                          // print(DateFormat('HH:mm:ss').parse(stringged));
                          // return;
                          print(endhours);
                          print(starthours);

                          if ((_formKey.currentState!.validate())) {
                            var task = Todo(
                              intitule: taskvalue,
                              status: false,
                              dateTask: dateValue.toString(),
                              hoursEndTask:
                                  "${endhours.hour} : ${endhours.minute}",
                              hoursTartTask:
                                  "${starthours.hour} : ${starthours.minute}",
                            );
                            if (widget.task == null) {
                              setState(() {
                                TodoList.todos.insert(0, task);
                                TodoList.saveToStorage(list);
                              });
                            } else {
                              // var indice = TodoList.todos.indexWhere(
                              //     (temp) => temp.id == widget.task.id);
                              // print(" l'indice est :$indice");

                              // if (indice != -1) {
                              //   setState(() {
                              //     TodoList.todos[indice].intitule = taskvalue;
                              //     _saveToStorage();
                              //   });
                              // }
                              // print(" les data sont$change");
                            }
                            _taskController.clear();
                            taskvalue = "";

                            // var lastValue = widget.task.intitule;

                            // print()

                            // var newValue =
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              widget.task == null
                                  ? "ajouter votre tache"
                                  : "Editer la tache",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(dateValue);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: const Icon(Icons.remove_red_eye_sharp),
        ),
      ),
    );
  }

  void redUpdateTask(String task) {
    _taskController.text = task;
  }

  // _addItem(String title) {
  //   setState(() {
  //     final item = Todo(intitule: '', status: false);
  //     list.todos.insert(0, item);
  //     _saveToStorage();
  //   });
  // }

  // dynamic stringToTimeOfDay(tod) {
  //   final format = DateFormat.Hm(); //"6:00 AM"
  //   // return format.parse(tod).;
  //   return DateFormat.Hms().format(tod);
  // }
}
