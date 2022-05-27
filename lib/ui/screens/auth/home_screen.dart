import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/ui/screens/after_sign_in.dart';
import 'package:dummy_app/ui/screens/auth/sign_in_screen.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final networkStatus = Provider.of<ConnectivityResult>(context);
    // final networkStatus2 = Provider.of<NetworkStatus>(context);
    // print(
    //     "Data Connection has no Internet ${networkStatus} +  ${networkStatus2}");
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.data == "Not Logged In" &&
            snapshot.connectionState == ConnectionState.done) {
          return const SignInScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const AfterSignIn();
        }
        return Scaffold(
          body: Center(
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
          ),
        );
      },
      future: userDataisSavedOrNot(context),
    );
  }
}

userDataisSavedOrNot(BuildContext context) async {
  final SharedPreferences userPrefrences =
      await SharedPreferences.getInstance();
  final bool? sharedPreferencesData = userPrefrences.getBool("isRemember");
  if (sharedPreferencesData == null || sharedPreferencesData == false) {
    return 'Not Logged In';
  } else {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    await Provider.of<AuthRequest>(context, listen: false).signInFunction(
      prefs.getString("email"),
      prefs2.getString("password"),
    );
    return sharedPreferencesData;
  }
}
