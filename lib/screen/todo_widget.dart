import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/screen/home.dart';

import 'package:todoapp/screen/todo_insert.dart';
import 'package:todoapp/utils/utils.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    super.key,
    required this.todo,
  });
  final Todo todo;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final TodoList list = TodoList();

  @override
  Widget build(BuildContext context) {
    var task = widget.todo;
    var start = DateTime.parse(task.hoursTartTask);
    var end = DateTime.parse(task.hoursEndTask);
    var duration = end.difference(start).inHours;
    var durationText = "$duration Heures ";
    if (duration >= 24) {
      var jour = duration ~/ 24;
      var heure = (jour - (duration / 24)).abs();
      heure = heure > 0 ? (heure * 10) : 0;

      durationText = "$jour jours ";
      durationText += heure > 0 ? "${heure.toInt()}  Heures" : "";
    }

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 20, top: 15, bottom: 15),
      margin: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // SizedBox(
          //   height: 20,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [

          //     ],
          //   ),
          // ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 33),
                    width: 310,
                    child: Text(
                      task.intitule,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          decoration: task.status
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -15,
                left: -7,
                child: Checkbox(
                  value: task.status,
                  checkColor: task.status
                      ? const Color.fromARGB(
                          255,
                          216,
                          19,
                          19,
                        )
                      : Colors.transparent,
                  onChanged: (values) {
                    setState(() {
                      var index = TodoList.todos
                          .indexWhere((element) => element.id == task.id);
                      TodoList.todos[index].status =
                          !TodoList.todos[index].status;

                      TodoList.saveToStorage(list);
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 30),
            margin: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils().textDate(start, "Start"),
                Utils().textDate(end, "end"),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Text(
                  " Durée : $durationText ",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  task.status == false
                      ? IconButton(
                          iconSize: 10,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(1),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsertTdodo(
                                  task: task,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          ))
                      : const SizedBox(
                          width: 1,
                        ),
                  IconButton(
                    padding: EdgeInsets.all(1),
                    onPressed: () {
                      _showMyDialog(task.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
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
              child: const Text("Non"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  TodoList.todos.removeWhere((temp) => temp.id == taskID);
                });
                TodoList.saveToStorage(list);
                Navigator.pop(context);
              },
              child: const Text("Oui"),
            ),
          ],
        );
      },
    );
  }
}
