import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/auth/enter_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/ForgotPassword';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final email = TextEditingController(
      // text: 'shahryar.r101@gmail.com'
      );

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
          await Provider.of<AuthRequest>(context, listen: false)
              .forgotPassword(email.text);
      if (isCrendentialTrue == true) {
        _btnController.stop();
        if (!mounted) return; setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamed(EnterOTP.routeName);
      } else {
        _btnController.stop();
        if (!mounted) return; setState(() {
          isLoading = false;
        });
      }
    } else {
      if (!mounted) return; setState(() {
        isLoading = false;
      });
      _btnController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
                  'Email',
                  TextInputType.emailAddress,
                  TextInputAction.go,
                  readOnly: isLoading,
                  fieldsubmited: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
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
                      'Send Otp To Email',
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
    );
  }
}
