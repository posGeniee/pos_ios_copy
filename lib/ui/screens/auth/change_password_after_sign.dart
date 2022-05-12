import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/after_sign_in.dart';
import 'package:dummy_app/ui/screens/auth/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordAfterSignIn extends StatefulWidget {
  static const routeName = '/ChangePasswordAfterSignIn';
  const ChangePasswordAfterSignIn({Key? key}) : super(key: key);

  @override
  State<ChangePasswordAfterSignIn> createState() =>
      _ChangePasswordAfterSignInState();
}

class _ChangePasswordAfterSignInState extends State<ChangePasswordAfterSignIn> {
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final currentPassword = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _doSomething() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _btnController.start();
      final signInModelData =
          Provider.of<AuthRequest>(context, listen: false).signiModelGetter;

      bool isCrendentialTrue =
          await Provider.of<AuthRequest>(context, listen: false)
              .changePasswordAfterAuth(
        password.text,
        currentPassword.text,
        signInModelData.data!.bearer,
      );
      if (isCrendentialTrue == true) {
        _btnController.stop();
        setState(() {
          isLoading = false;
          password.text = '';
          currentPassword.text = '';
          confirmPassword.text = '';
        });
      } else {
        _btnController.stop();
        setState(() {
          isLoading = false;
          password.text = '';
          currentPassword.text = '';
          confirmPassword.text = '';
        });
      }
    } else {
      _btnController.stop();
      setState(() {
        isLoading = false;
        password.text = '';
        currentPassword.text = '';
        confirmPassword.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userNameInfo = Provider.of<AuthRequest>(
      context,
    ).signiModelGetter.data;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: currentPassword,
                      readOnly: isLoading,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        }
                        if (password.text == currentPassword.text) {
                          return 'Current password and password matches';
                        }
                        if (password.text.length < 2) {
                          return 'The password must be at least 2 characters.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Please enter Current password',
                        labelText: 'Enter Current password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  appField(
                    password,
                    'Password',
                    TextInputType.visiblePassword,
                    TextInputAction.next,
                    isPasswordtrue: true,
                    readOnly: isLoading,
                    fieldsubmited: _doSomething,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: confirmPassword,
                      readOnly: isLoading,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Confirm password';
                        }
                        if (password.text != confirmPassword.text) {
                          return 'Confirm password does not match';
                        }
                        if (password.text.length < 2) {
                          return 'The password must be at least 2 characters.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        hintText: 'Please enter Confirm password',
                        labelText: 'Enter Confirm password',
                      ),
                      obscureText: true,
                      onFieldSubmitted: (value) {
                        // _doSomething();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: RoundedLoadingButton(
                      height: 60,
                      color: buttonColor,
                      width: constraints.maxWidth - 150,
                      child: const Text(
                        'Change Password',
                      ),
                      controller: _btnController,
                      onPressed: _doSomething,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: buttonColor,
              ),
              child: Center(
                child: Text(
                  'Hey ${userNameInfo!.surname} ${userNameInfo.firstName} ${userNameInfo.lastName}',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home Screen',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: buttonColor),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacementNamed(AfterSignIn.routeName);
              },
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: buttonColor),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
