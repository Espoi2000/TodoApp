import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:localstorage/localstorage.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screen/home.dart';

import 'package:todoapp/utils/utils.dart';

class InsertTdodo extends StatefulWidget {
  const InsertTdodo({
    super.key,
    this.task,
  });
  final task;

  @override
  State<InsertTdodo> createState() => _InsertTdodoState();
}

class _InsertTdodoState extends State<InsertTdodo> {
  final LocalStorage storage = LocalStorage('todo_app');
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _startPeriodController = TextEditingController();
  final TextEditingController _endPeriodController = TextEditingController();

  bool tcheked = false;
  var updateTaskSaving = "";
  String taskvalue = "";
  String lastvalue = "";
  String newValeu = "";
  final _formKey = GlobalKey<FormState>();
  TodoList list = TodoList();
  dynamic startPeriod;
  dynamic endPeriod;
  var timezone;
  List<String> _availableTimezones = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      if (widget.task != null) {
        _taskController.text = widget.task.intitule;
        _endPeriodController.text = widget.task.hoursEndTask;
        _startPeriodController.text = widget.task.hoursTartTask;
        endPeriod = _endPeriodController.text;
        startPeriod = _startPeriodController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Utils().richtext(context, "Decouvrez un moyen ",
                            "Facile ", " De Gerer Vos ", " Taches"),
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
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      fillColor: const Color.fromRGBO(
                                          217, 217, 217, 0.4),
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

                                // choix des heures

                                // choix des heures
                                const SizedBox(
                                  height: 10,
                                ),

                                TextFormField(
                                  controller: _startPeriodController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "veuillez entrer la date de debut";
                                    }
                                    // if (startPeriod.compareTo(endPeriod) > 0) {
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
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      fillColor: const Color.fromRGBO(
                                          217, 217, 217, 0.4),
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
                                          startPeriod =
                                              await selectDateTime(context);

                                          if (startPeriod != null) {
                                            setState(() {
                                              _startPeriodController.text =
                                                  startPeriod.toString();
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
                                  controller: _endPeriodController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "veuillez entrer l'heure de fin";
                                    }
                                    if (endPeriod!.compareTo(startPeriod) > 0) {
                                      return null;
                                    } else {
                                      return "la date de fin doit superieurs a la date de debut ";
                                    }
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
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      fillColor: const Color.fromRGBO(
                                          217, 217, 217, 0.4),
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
                                          endPeriod =
                                              await selectDateTime(context);

                                          setState(() {
                                            _endPeriodController.text =
                                                endPeriod.toString();
                                          });
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
                                    print(taskvalue);
                                    print(_endPeriodController.text);
                                    print(_startPeriodController.text);

                                    if ((_formKey.currentState!.validate())) {
                                      var task = Todo(
                                        intitule: taskvalue,
                                        status: false,
                                        hoursEndTask: endPeriod.toString(),
                                        hoursTartTask: startPeriod.toString(),
                                      );

                                      if (widget.task == null) {
                                        setState(() {
                                          TodoList.todos.insert(0, task);
                                          TodoList.saveToStorage(list);
                                        });
                                      } else {
                                        var indice = TodoList.todos.indexWhere(
                                            (temp) =>
                                                temp.id == widget.task.id);

                                        if (indice != -1) {
                                          setState(() {
                                            TodoList.todos[indice].intitule =
                                                taskvalue;
                                            TodoList.saveToStorage(list);
                                          });
                                        }
                                      }
                                      showConfirmDialogueTaskt(context);
                                      _taskController.clear();
                                      _endPeriodController.clear();
                                      _startPeriodController.clear();
                                      taskvalue = "";
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.task == null
                                            ? "Ajouter Votre Tache"
                                            : "Editer La Tache",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void redUpdateTask(String task) {
    _taskController.text = task;
  }

  selectDateTime(BuildContext context) {
    return showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
      primaryColor: Colors.cyan,
      backgroundColor: Colors.grey[900],
      calendarTextColor: Colors.white,
      tabTextColor: Colors.white,
      unselectedTabBackgroundColor: Colors.grey[700],
      buttonTextColor: Colors.white,
      timeSpinnerTextStyle:
          const TextStyle(color: Colors.white70, fontSize: 18),
      timeSpinnerHighlightedTextStyle:
          const TextStyle(color: Colors.white, fontSize: 24),
      is24HourMode: true,
      isShowSeconds: false,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      borderRadius: const Radius.circular(16),
    );
  }

  commonMessage() {
    return const SnackBar(
      content: Text("Enregistrement Effectué",
          style: TextStyle(color: Colors.white)),
      backgroundColor: (Colors.green),
    );
  }

  Future showConfirmDialogueTaskt(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            widget.task == null ? "Enregistrement effectué " : " Tache Edité",
          ),
          actions: [
            TextButton(
              child: const Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
