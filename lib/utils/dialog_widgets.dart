import 'package:flutter/material.dart';

class DialogWidgets {
  static void showExceedDialog(BuildContext context, String selectedCategory) {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Budget Exceeded'),
            content: Text('The budget for $selectedCategory has been exceeded.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error showing exceed dialog: $e');
    }
  }

  static void showNotExceedDialog(BuildContext context, String selectedCategory) {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Budget Not Exceeded'),
            content: Text('The budget for $selectedCategory has not been exceeded.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error showing exceed dialog: $e');
    }
  }
}
