import 'dart:math';

import 'package:dummy_app/ui/screens/pos/pos_main.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../data/network/auth_request.dart';
import '../../../helpers/const.dart';
import '../../../helpers/helper function api/pos_module_api.dart';
import '../../../helpers/scalling.dart';
import 'dart:math' as math;

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({Key? key}) : super(key: key);

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  final _formKeyAddNewCustomer = GlobalKey<FormState>();
  final name = TextEditingController();
  final mobile_no = TextEditingController();
  final email = TextEditingController();
  final zip_code = TextEditingController();
  final dob = TextEditingController();
  final asking = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool isLoading = false;
  String dropdownValue = 'Through Social Media';

  // List of items in our dropdown menu
  var items = [
    'Through Social Media',
    'Through Friends',
    'Through our website',
    'Through Google',
  ];

   late String token;

  @override
  Widget build(BuildContext context) {
    init(context);
    token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;

    var textFieldTopPadding = height(22);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "Add New Customer",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKeyAddNewCustomer,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(25)),
                  child: Column(
                    children: [
                      SizedBox(height: height(10)),
                      Padding(
                        padding: EdgeInsets.only(top: textFieldTopPadding),
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Customer Name!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'Customer Name',
                            hintText: 'Name',
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: textFieldTopPadding),
                        child: TextFormField(
                          controller: mobile_no,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Customer Mobile No!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Customer Mobile No',
                            hintText: 'Mobile No',
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: textFieldTopPadding),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Customer Email!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Customer Email',
                            hintText: 'Email',
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: textFieldTopPadding),
                        child: TextFormField(
                          controller: zip_code,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Customer Zip code!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Customer Zip code',
                            hintText: 'Zip code',
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: textFieldTopPadding),
                        child: TextFormField(
                          controller: dob,
                          readOnly: true,
                          validator: (value) {
                            print('value >>>>>>> $value');
                            if (value == null || value.isEmpty) {
                              return 'Please select Customer DOB!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Customer DOB',
                              hintText: 'DOB',
                              hintStyle: TextStyle(fontSize: 14),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: buttonColor),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF8D8D8D)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: SvgPicture.asset('assets/calendar.svg',
                                    color: buttonColor),
                              )),
                          onTap: () {
                            BottomPicker.date(
                              title: 'Select DOB',
                              titleStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width(15),
                                color: buttonColor,
                              ),
                              dateOrder: DatePickerDateOrder.dmy,
                              pickerTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width(13),
                                color: Colors.black,
                              ),
                              onChange: (index) {
                                print(index);
                              },
                              onSubmit: (date) {
                                // setState(() {
                                //   dob.text = date.toString();
                                // });

                                final dateFormat = DateFormat('dd MMM yyyy');
                                dob.text = dateFormat.format(date);
                                print('DOB >>>>>>>>>>> ...${dob.text}');
                              },
                              bottomPickerTheme: BOTTOM_PICKER_THEME.orange,
                            ).show(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: textFieldTopPadding),
                        child: DropdownSearch<String>(
                          mode: Mode.DIALOG,
                          showSelectedItems: true,
                          items: items,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select one option from list!';
                            }
                            return null;
                          },
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Where do you hear about us",
                            hintText: "Where do you hear about us",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: buttonColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF8D8D8D)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          dropdownButtonProps: IconButtonProps(
                              iconSize: 20,
                              icon: Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: Icon(Icons.arrow_forward_ios)),
                              color: buttonColor),
                          onChanged: print,
                          selectedItem: dropdownValue,
                        ),
                      ),
                      SizedBox(height: height(40)),
                      RoundedLoadingButton(
                        height: height(65),
                        color: buttonColor,
                        width: width(200),
                        child: const Text(
                          'Register',
                        ),
                        controller: _btnController,
                        onPressed: _addNewCustomer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _addNewCustomer() async {
    if (_formKeyAddNewCustomer.currentState!.validate()) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      _btnController.start();

      ///implementation..........
      var addCustomer = await PosModuleApi().addCustomer(token, name.text, mobile_no.text, email.text, zip_code.text, dob.text);
      print('addCustomer : $addCustomer');

      if(addCustomer.toString().isNotEmpty){
        print('Customer Added Successfully.................');
        Navigator.of(context).pop();
      }

      _btnController.stop();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } else {
      _btnController.stop();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }
}
