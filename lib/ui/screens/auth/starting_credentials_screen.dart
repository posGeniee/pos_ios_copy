import 'package:dummy_app/ui/screens/auth/first_screen.dart';
import 'package:dummy_app/ui/screens/auth/home_screen.dart';
import 'package:dummy_app/ui/screens/auth/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/widget.dart';

class StartingCredentialsScreen extends StatefulWidget {
  const StartingCredentialsScreen({Key? key}) : super(key: key);

  @override
  State<StartingCredentialsScreen> createState() =>
      _StartingCredentialsScreenState();
}

class _StartingCredentialsScreenState extends State<StartingCredentialsScreen> {
  credendials() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    credendials();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.data == "Not Provided Credentials" &&
            snapshot.connectionState == ConnectionState.done) {
          return const FirstScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const HomeScreen();
        }
        return Scaffold(
          body: circularProgress,
        );
      },
      future: userDataisSavedOrNot(context),
    );
  }

  userDataisSavedOrNot(BuildContext context) async {
    final SharedPreferences userPrefrences = await SharedPreferences.getInstance();
    if (userPrefrences.getString('terminal_id') != null) {
      print('userPrefrences >>>>>>>>> ${userPrefrences.getString('terminal_id')}');
    } else {
      return 'Not Provided Credentials';
    }
  }
}
