import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/ui/screens/auth/change_password.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EnterOTP extends StatefulWidget {
  static const routeName = '/EnterOTP';
  const EnterOTP({Key? key}) : super(key: key);

  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
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
      final email =
          Provider.of<AuthRequest>(context, listen: false).emailTextGetter;
      bool isCrendentialTrue =
          await Provider.of<AuthRequest>(context, listen: false)
              .verifyyOtp(_pinPutController.text, email);
      if (isCrendentialTrue == true) {
        Navigator.of(context).pushNamed(ChangePassword.routeName);
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
      edgeAlert(context,
          gravity: Gravity.top,
          title: "Please enter the pin",
          icon: Icons.error_outline,
          backgroundColor: Colors.red);
      if (!mounted) return; setState(() {
        isLoading = false;
      });
      _btnController.stop();
    }
  }

  Widget justRoundedCornersPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: buttonColor,
      ),
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: PinPut(
            fieldsCount: 4,
            // withCursor: true
            textStyle: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: buttonColor),
            eachFieldWidth: 50.0,
            eachFieldHeight: 50.0,
            onSubmit: (String pin) {
              // _doSomething();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: pinPutDecoration,
            selectedFieldDecoration: pinPutDecoration,
            followingFieldDecoration: pinPutDecoration,
            pinAnimationType: PinAnimationType.fade,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter pin';
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Column(
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
                  justRoundedCornersPinPut(),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: RoundedLoadingButton(
                      height: 60,
                      color: buttonColor,
                      width: constraints.maxWidth - 150,
                      child: const Text(
                        'Submit',
                      ),
                      controller: _btnController,
                      onPressed: _doSomething,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
