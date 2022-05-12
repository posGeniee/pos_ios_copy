import 'package:flutter/material.dart ';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//TextField of the App
appField(TextEditingController controller, String labelText,
    TextInputType textInputType, TextInputAction textInputAction,
    {bool? isPasswordtrue, Function? fieldsubmited, required bool readOnly}) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: TextFormField(
      controller: controller,
      readOnly: readOnly,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        // if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //             .hasMatch(value) ==
        //         false &&
        //     labelText.contains("Email")) {
        //   return 'Please enter valid email';
        // }
        if (value.length < 2 && labelText.contains("Email")) {
          return 'The password must be at least 2 characters.';
        }
        return null;
      },
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: 'Please enter $labelText',
        labelText: labelText,
      ),
      obscureText: isPasswordtrue ?? false,
      onFieldSubmitted: (value) {
        fieldsubmited!();
      },
    ),
  );
}

//app Bottom Sheet
showModelSheetofApp(BuildContext context) {
  return showBarModalBottomSheet(
    context: context,
    enableDrag: true,
    expand: true,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Text("data");
              },
              itemCount: 10,
            ),
          );
        },
      );
    },
  );
}

//App Drawer
Drawer appDrawer() {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}

Widget circularProgress = Center(
  child: SizedBox(
    height: 80,
    width: 80,
    child: CircularProgressIndicator(
      backgroundColor: Colors.blue,
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.white.withOpacity(0.5),
      ),
      strokeWidth: 1.5,
    ),
  ),
);

// new TextFiled Approch in Maintainance Module.
newAppField(
  TextEditingController controller,
  String labelText,
  TextInputType textInputType,
  List<TextInputFormatter> inputFormatter,
  TextInputAction textInputAction, {
  bool? isPasswordtrue,
  // Function? fieldsubmited,
  required bool readOnly,
}) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: TextFormField(
      controller: controller,
      readOnly: readOnly,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        // if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //             .hasMatch(value) ==
        //         false &&
        //     labelText.contains("Email")) {
        //   return 'Please enter valid email';
        // }
        if (value.length < 2 && labelText.contains("Email")) {
          return 'The password must be at least 2 characters.';
        }
        return null;
      },
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        hintText: 'Please enter $labelText',
        labelText: labelText,
      ),
      obscureText: isPasswordtrue ?? false,
      onFieldSubmitted: (value) {
        // fieldsubmited!();
      },
    ),
  );
}
