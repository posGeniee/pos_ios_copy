import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/credentials_api_function.dart';
import 'package:dummy_app/helpers/scalling.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/auth/home_screen.dart';
import 'package:dummy_app/ui/screens/auth/second_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:math' as math;

import '../../../data/models/starting_credentials/get_location.dart';
import '../../../data/network/auth_request.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final api_link = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late var appLinkCorrect;

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            // print("This is the Height ${constraints.maxHeight}");
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: TextFormField(
                      controller: api_link,
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter API Link!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'API Link',
                        hintText: 'API Link',
                        hintStyle: TextStyle(fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: buttonColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8D8D8D)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onChanged: (api_link) {

                        appLinkCorrect = Uri.parse(api_link).isAbsolute;
                        print(
                            'api_link >>>>>>>>>>> $api_link ... appLinkCorrect : $appLinkCorrect');

                        if (appLinkCorrect) {
                          appUrl = api_link;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                  Container(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: RoundedLoadingButton(
                        height: 60,
                        color: buttonColor,
                        width: constraints.maxWidth - 150,
                        child: Text(
                          'Next',
                        ),
                        controller: _btnController,
                        onPressed: () {
                          if (_formKey.currentState!.validate() && appLinkCorrect) {
                            print(
                                'If_formKey.currentState!.validate(): ${_formKey.currentState!.validate()}');
                            if (!mounted) return;
                            setState(() {
                              isLoading = true;
                            });
                            _btnController.start();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SecondScreen()));

                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                            });
                            _btnController.stop();
                          } else if(_formKey.currentState!.validate() && appLinkCorrect == false){
                            edgeAlert(context,
                                gravity: Gravity.top,
                                title: "Please enter correct API Link!",
                                icon: Icons.error_outline,
                                backgroundColor: Colors.red);

                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                            });
                            _btnController.stop();
                          } else{
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                            });
                            _btnController.stop();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
