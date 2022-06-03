import 'package:dummy_app/helpers/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showExitAlert(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context,rootNavigator: true).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Exit", style: TextStyle(color: buttonColor)),
    onPressed:  () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // SystemNavigator.pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice!"),
    content: Text('Are you sure you want to exit app?'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}