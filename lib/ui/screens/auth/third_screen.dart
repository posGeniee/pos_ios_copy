import 'dart:convert';

import 'package:dummy_app/data/models/starting_credentials/get_terminal.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/starting_credentials/get_location.dart';
import '../../../data/network/starting_credential_provider.dart';
import '../../../helpers/const.dart';
import '../../../helpers/helper function api/credentials_api_function.dart';
import '../../../helpers/widget.dart';
import 'home_screen.dart';
import 'dart:math' as math;

class ThirdScreen extends StatefulWidget {
  int locationId;

  ThirdScreen(this.locationId, {Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  List<GetTerminalDatum> getTerminals = [];
  late String terminalId;

  getTerminal() async {
    final getTerminalsList =
        await CredentialsApi().getTerminals(widget.locationId);
    print('getTerminalsList : $getTerminalsList');
    Provider.of<CredentialProvider>(context, listen: false)
        .terminalsListSetter(getTerminalsList);

    final terminals = Provider.of<CredentialProvider>(context, listen: false)
        .terminalsListGetter;

    if (!mounted) return;
    setState(() {
      isLoading = false;
      getTerminals = terminals;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTerminal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)
          ? circularProgress
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
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
                        const SizedBox(height: 70),
                        Padding(
                          padding: EdgeInsets.all(18),
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.dialog(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Select Terminal",
                                hintText: "Terminal",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: buttonColor),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF8D8D8D)),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),

                            items: getTerminals.map((e) => '${e.id}').toList(),
                            // items: terminalItems,
                            validator: (value) {
                              if (value == 'Terminal') {
                                return 'Please select terminal from list!';
                              }
                              return null;
                            },

                            dropdownButtonProps: DropdownButtonProps(
                                iconSize: 20,
                                icon: Transform.rotate(
                                    angle: 90 * math.pi / 180,
                                    child: Icon(Icons.arrow_forward_ios)),
                                color: buttonColor),

                            onChanged: (terminal_id) {
                              setState(() {
                                terminalId = terminal_id!;
                              });
                            },
                            selectedItem: 'Terminal',
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
                              child: const Text(
                                'Submit',
                              ),
                              controller: _btnController,
                              onPressed: _doSomething,
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

  void _doSomething() async {
    if (_formKey.currentState!.validate()) {
      if (!mounted) return;
      _btnController.start();

      var result = await CredentialsApi().updateTerminals(terminalId);
      print('result >>>>>>>>>>> $result');

      if (result.toString().isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("terminal_id", terminalId);
        print('prefs >>>>>>>>> ${prefs.getString('terminal_id')}');

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));

        if (!mounted) return;
        _btnController.stop();
      } else {
        if (!mounted) return;
        _btnController.stop();
      }
    } else {
      if (!mounted) return;
      _btnController.stop();
    }
  }
}
