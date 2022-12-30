import 'package:flutter/material.dart';
import 'package:todoapp/model/todomodel.dart';

class Utils {
  Future showDialogueTaskt(BuildContext context, controller, textTitle,
      testbutton, button, task) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textTitle),
          content: SizedBox(
            height: 50,
            width: 100,
            child: Column(
              children: [
                SizedBox(height: 50, width: double.infinity, child: Column())
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(task != null ? "Editer" : "Ajouter"),
              onPressed: () {
                // add
                // controller.clear();

                // addTodoItem(task);addTodoItem(Todo todoItem) {

                Navigator.of(context).pop(task);
              },
            )
          ],
        );
      },
    );
  }

  // textButtonSubmit(BuildContext context, textButton, controller,taskval) {
  //   return InkWell(
  //     onTap: () {
  //       taskval = controller.text;
  //       var task = Todo(tache: taskval, tckeck: false);
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width / 2,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: Colors.red,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Center(
  //         child: Text(
  //           textButton,
  //           style: const TextStyle(color: Colors.white, fontSize: 17),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  titleForm(BuildContext context, text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
  // dynamic editOrSaveButton(text, controller, context, showButton) {
  //   return (showButton == "ajout")
  //       ? TextButton(
  //           child: Text(text),
  //           onPressed: () {
  //             var taskvalue = controller.text;
  //             // print(taskvalue);
  //             controller.clear();
  //             var task = Todo(tache: taskvalue, tckeck: false);

  //             addTodoItem(task);

  //             Navigator.of(context).pop();
  //           },
  //         )
  //       : TextButton(
  //           child: Text(text),
  //           onPressed: () {
  //             var taskvalue = controller.text;
  //             // print(taskvalue);
  //             controller.clear();
  //             var task = Todo(tache: taskvalue, tckeck: false);
  //             Navigator.of(context).pop();
  //           },
  //         );
  // }
  // _toggleItem(bool value, int i) {
  //   setState(() {
  //     list.todos[i].tckeck = !list.todos[i].tckeck;
  //     _saveToStorage();
  //   });
  // }
}



// taskvalue = _TaskController.text;
//                 // print(taskvalue);
//                 _TaskController.clear();
//                 var task = Todo(tache: taskvalue, tckeck: false);
//                   addTodoItem(task);
