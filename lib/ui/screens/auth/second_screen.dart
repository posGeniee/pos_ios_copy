import 'package:dummy_app/ui/screens/auth/third_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../data/models/starting_credentials/get_location.dart';
import '../../../data/network/auth_request.dart';
import '../../../data/network/starting_credential_provider.dart';
import '../../../helpers/const.dart';
import '../../../helpers/helper function api/credentials_api_function.dart';
import '../../../helpers/widget.dart';
import 'home_screen.dart';
import 'dart:math' as math;


class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final api_link = TextEditingController();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  List<GetLocationDatum> getLocations = [];
  late int location;

  getLocation() async {
    late List<GetLocationDatum> locations;
    locations = Provider
        .of<CredentialProvider>(context, listen: false)
        .locationsListGetter;

    print('locations >>>>>>>>>> $locations');

    if(locations.isEmpty) {
      //Get Locations List Api call....
      final getLocationsList = await CredentialsApi().getLocation();
      print('getLocationsList : $getLocationsList');
      Provider.of<CredentialProvider>(context, listen: false)
          .locationsListSetter(getLocationsList);

      locations = Provider
          .of<CredentialProvider>(context, listen: false)
          .locationsListGetter;

      if (!mounted) return;
      setState(() {
        isLoading = false;
        getLocations = locations;
      });
    }else{
      if (!mounted) return;
      setState(() {
        isLoading = false;
        getLocations = locations;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
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
                      const SizedBox(height: 70),
                      Padding(
                        padding: EdgeInsets.all(18),
                        child: DropdownSearch<String>(
                          mode: Mode.DIALOG,
                          showSelectedItems: true,
                          showSearchBox: true,
                          items: getLocations.map((e) => e.name).toList(),
                          validator: (value) {
                            if (value == 'Location') {
                              return 'Please select location from list!';
                            }
                            return null;
                          },
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Select Location",
                            hintText: "Location",
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
                          // onChanged: print,
                          onChanged: (locationName) {
                            print('locationName >>>>>>>>>>> $api_link');

                            getLocations.where((element) {
                              if(element.name == locationName) {
                                location = element.locationId;
                                print('location >>>>>>> $location');
                              }
                              return false;
                            }).toList();
                          },
                          selectedItem: 'Location',
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
                              'Next',
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
      setState(() {
        isLoading = true;
      });
      _btnController.start();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ThirdScreen(location)));

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      _btnController.stop();
    } else {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      _btnController.stop();
    }
  }
}
