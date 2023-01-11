import 'package:flutter/material.dart';
import 'package:todoapp/screen/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  titleForm(BuildContext context, text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  richtext(BuildContext context, text1, text2, test3, text4) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text1,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w700,
          letterSpacing: .2,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: text2,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 35,
              fontWeight: FontWeight.w700,
              letterSpacing: .2,
            ),
          ),
          TextSpan(
            text: test3,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              height: 1,
              letterSpacing: .2,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: text4,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 35,
              fontWeight: FontWeight.w700,
              letterSpacing: .2,
            ),
          ),
        ],
      ),
    );
  }

  textDate(DateTime date, String libelleDate) {
    initializeDateFormatting();
    var dateformat = DateFormat('EEEE d-MMM-yyyy ,', 'fr').format(date);

    return Text(
      libelleDate == "end"
          ? "Fin : $dateformat À ${date.hour}H:${date.minute}min"
          : "Début : $dateformat   À ${date.hour}H:${date.minute}min",
      // "${date.day} - ${date.month} - ${date.year} ${ate.hour}:${date.minute}",
      style: TextStyle(
        color: libelleDate == "end" ? Colors.red : Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    );
  }
}
