import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/after_sign_in.dart';
import 'package:dummy_app/ui/screens/auth/forgot_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/SignInScreen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // superadmin
  final email = TextEditingController(text: 'superadmin');
//admin
  final password = TextEditingController(text: 'admin');

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _doSomething() async {
    if (_formKey.currentState!.validate()) {
      if (!mounted) return; setState(() {
        isLoading = true;
      });
      _btnController.start();
      bool isCrendentialTrue =
          await Provider.of<AuthRequest>(context, listen: false).signInFunction(email.text, password.text);
      if (isCrendentialTrue == true) {
        // Navigator.of(context).pop();

        // _btnController.stop();
        // if (!mounted) return; setState(() {
        //   isLoading = false;
        // });
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.clear();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        SharedPreferences prefs2 = await SharedPreferences.getInstance();
        SharedPreferences prefs3 = await SharedPreferences.getInstance();
        prefs.setString("email", email.text);
        prefs2.setString("password", password.text);
        prefs3.setBool("isRemember", _switchValue);

        Navigator.of(context).pushReplacementNamed(AfterSignIn.routeName);
      } else {
        if (!mounted) return; setState(() {
          isLoading = false;
        });
        _btnController.stop();
      }
    } else {
      if (!mounted) return; setState(() {
        isLoading = false;
      });
      _btnController.stop();
    }
  }

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    //  AuthRequest().signInFunction('alimughalktech@gmail.com', '12345678');
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          // print("This is the Height ${constraints.maxHeight}");
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/logo.png'),
                ),
                const SizedBox(
                  height: 50,
                ),
                appField(
                  email,
                  'Email or Username',
                  TextInputType.emailAddress,
                  TextInputAction.next,
                  fieldsubmited: () async {},
                  readOnly: isLoading,
                ),
                appField(
                  password,
                  'Password',
                  TextInputType.visiblePassword,
                  TextInputAction.done,
                  isPasswordtrue: true,
                  fieldsubmited: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  readOnly: isLoading,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Remeber Me',
                      style: Theme.of(context).textTheme.button,
                    ),
                    CupertinoSwitch(
                      value: _switchValue,
                      activeColor: buttonColor,
                      onChanged: (value) {
                        if (!mounted) return; setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ForgotPassword.routeName);
                      },
                      child: Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.button!.copyWith(
                            decoration: TextDecoration.underline,
                            color: buttonColor),
                      ),
                    )
                  ],
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
                      'Continue',
                    ),
                    controller: _btnController,
                    onPressed: _doSomething,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
