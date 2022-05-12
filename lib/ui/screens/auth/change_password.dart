import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/ChangePassword';
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final password = TextEditingController();

  final confirmPassword = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _doSomething() async {
    if (_formKey.currentState!.validate()) {
      final email =
          Provider.of<AuthRequest>(context, listen: false).emailTextGetter;
      final otp =
          Provider.of<AuthRequest>(context, listen: false).otpTextGetter;

      if (!mounted) return; setState(() {
        isLoading = true;
      });
      _btnController.start();
      bool isCrendentialTrue =
          await Provider.of<AuthRequest>(context, listen: false)
              .changePassword(email, password.text, password.text, otp);
      if (isCrendentialTrue == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
        _btnController.stop();
        if (!mounted) return; setState(() {
          isLoading = false;
        });
      } else {
        _btnController.stop();
        if (!mounted) return; setState(() {
          isLoading = false;
        });
      }
    } else {
      _btnController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: LayoutBuilder(
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
                    password,
                    'Password',
                    TextInputType.visiblePassword,
                    TextInputAction.next,
                    isPasswordtrue: true,
                    readOnly: isLoading,
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
    );
  }
}
