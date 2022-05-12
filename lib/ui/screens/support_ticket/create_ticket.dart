import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/support_ticket_api_functions.dart';
import 'package:dummy_app/ui/screens/support_ticket/list_of_ticket.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CreateTicket extends StatefulWidget {
  static const routeName = '/CreateTicket';
  const CreateTicket({Key? key}) : super(key: key);

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  final subject = TextEditingController();
  // final teamPassword = TextEditingController();
  final teamDescription = TextEditingController();
  final List<String> issuesType = [
    'home',
    'user_management',
    'contacts',
    'products',
    'service',
    'purchases',
    'stock_transfers',
    'stock_adjustment',
    'sell',
    'daily_book',
    'expenses',
    'bank',
    'lottery',
    'report',
    'new_report',
    'maintenance',
    'notification_templates',
    'hrm',
    'essentials',
  ];

  final List<String> string = [
    'low',
    'medium',
    'high',
  ];

  String? selectedValue;
  String? selectedValuePriorty;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _doSomething() async {
    if (_formKey.currentState!.validate()) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      _btnController.start();
      final signInModelData =
          Provider.of<AuthRequest>(context, listen: false).signiModelGetter;
      final locationIdData = Provider.of<AuthRequest>(context, listen: false)
          .locationFromApiGetter;

      bool isCrendentialTrue = await SupportTicketsApiFunction().addTicket(
          locationIdData.id.toString(),
          signInModelData.data!.firstName,
          signInModelData.data!.email,
          subject.text,
          selectedValuePriorty.toString(),
          teamDescription.text,
          signInModelData.data!.bearer,
          selectedValue.toString());
      if (isCrendentialTrue == true) {
        _btnController.stop();
        if (!mounted) return;
        setState(() {
          isLoading = false;
          subject.text = '';

          // teamPassword.text = '';
          teamDescription.text = '';
        });
        edgeAlert(
          context,
          title: 'Support detail added successfully',
          backgroundColor: Colors.green,
        );
      } else {
        _btnController.stop();
        if (!mounted) return;
        setState(() {
          isLoading = false;
          subject.text = '';
          // teamPassword.text = '';
          teamDescription.text = '';
        });
        edgeAlert(
          context,
          title: 'Support detail added failed',
          backgroundColor: Colors.red,
        );
      }
    } else {
      _btnController.stop();
      if (!mounted) return;
      setState(() {
        isLoading = false;
        subject.text = '';
        teamDescription.text = '';
        // teamPassword.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Support Ticket",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PreviousTickets.routeName);
              },
              icon: const Icon(CupertinoIcons.tickets)),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: subject,
                  readOnly: isLoading,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subject';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Please enter Subject',
                    labelText: "Subject",
                  ),

                  onFieldSubmitted: (value) {},
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(18.0),
              //   child: TextFormField(
              //     controller: teamPassword,
              //     readOnly: isLoading,
              //     // The validator receives the text that the user has entered.
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter Team Password';
              //       }
              //       return null;
              //     },
              //     keyboardType: TextInputType.visiblePassword,
              //     textInputAction: TextInputAction.next,
              //     decoration: InputDecoration(
              //       hintText: 'Please enter Team Password',
              //       labelText: "Team Password (If Applicable) ",
              //     ),

              //     onFieldSubmitted: (value) {},
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Select Your Priorty',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: string
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Priorty.';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedValuePriorty = value.toString();
                    });
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    setState(() {
                      selectedValuePriorty = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Select Your Gender',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: issuesType
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select gender.';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
                    });
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    // selectedValue = value.toString();
                    setState(() {
                      selectedValue = value.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: teamDescription,
                  readOnly: isLoading,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  maxLines: 6,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Please enter Description',
                    labelText: "Description",
                  ),

                  onFieldSubmitted: (value) {
                    _doSomething();
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RoundedLoadingButton(
                height: 60,
                color: buttonColor,
                width: 200,
                child: const Text(
                  'Send Ticket ',
                ),
                controller: _btnController,
                onPressed: _doSomething,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
