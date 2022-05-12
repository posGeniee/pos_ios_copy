import 'dart:async';

import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/services/location_service.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AddTicketTrip extends StatefulWidget {
  static const routeName = '/AddTicketTrip';
  const AddTicketTrip({Key? key}) : super(key: key);

  @override
  _AddTicketTripState createState() => _AddTicketTripState();
}

class _AddTicketTripState extends State<AddTicketTrip> {
  final decriptionField = TextEditingController();

  final costField = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();

  final _geolocatorPlatform = GeolocatorPlatform.instance;

  List<DateTime> userDateTime = [];
  // final StreamController<UserLocation> _locationController =
  //     StreamController<UserLocation>.broadcast();
  List<UserLocation> userLocationData = [];

  bool isStart = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Trip",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async 
            {

              final args = ModalRoute.of(context)!.settings.arguments
                  as ScheduleModelDatum;
              bool validation = _formKey.currentState!.validate();
              if (validation &&
                  userDateTime.length >= 2 &&
                  userLocationData.length >= 2) {
                showLoading();
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;

                await MaintainanceApiFunction().addScheduleTrip(
                    args.id.toString(),
                    token,
                    locationId.toString(),
                    userDateTime,
                    userLocationData,
                    decriptionField.text,
                    costField.text);
                dismissLoading();

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                print(userDateTime.length);
                if (userDateTime.length == 2) {
                  edgeAlert(context,
                      title: 'Kindly Start and End Trip then Save');
                }
                // userDateTime = [];
                // userLocationData = [];
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // TimePicker(
              //   hintText: 'Start Time',
              //   timeController: startTimeField,
              // ),
              // TimePicker(
              //   hintText: 'End Time',
              //   timeController: endTimeField,
              // ),

              newAppField(
                  costField,
                  'Cost',
                  TextInputType.number,
                  [FilteringTextInputFormatter.digitsOnly],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(decriptionField, 'Description', TextInputType.name,
                  [], TextInputAction.next,
                  readOnly: false),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    if (isStart == false)
                      appButttonWithoutAnimation(
                          context, CupertinoIcons.forward, 'Start Trip',
                          () async {
                        var premission =
                            await _geolocatorPlatform.requestPermission();
                        print(
                            "This is the Premission record ${premission.name}");
                        // final Position positionFirst = await _determinePosition();

                        Location location = Location();
                        // location.enableBackgroundMode(enable: true);
                        LocationData _locationData;
                        _locationData = await location.getLocation();

                        userLocationData.add(UserLocation(
                          longitude: _locationData.longitude,
                          latitude: _locationData.latitude,
                        ));
                        userDateTime.add(DateTime.now());
                        // final positionStream = _geolocatorPlatform.getPositionStream(
                        //     locationSettings: locationSettings);
                        // location.onLocationChanged.listen((LocationData currentLocation) {
                        //   // current user location
                        //   userLocationData.add(UserLocation(
                        //     longitude: currentLocation.longitude,
                        //     latitude: currentLocation.latitude,
                        //   ));
                        // });

                        setState(() {
                          isStart = true;
                        });
                      })
                    else if (isStart && userLocationData.isNotEmpty)
                      Expanded(
                        child: GoogleMap(
                          myLocationEnabled: true,
                          markers: <Marker>{
                            Marker(
                              markerId: const MarkerId('Loc1'),
                              position: LatLng(
                                userLocationData[0].latitude as double,
                                userLocationData[0].longitude as double,
                              ),
                            ),
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            // bearing: 192.8334901395799,
                            target: LatLng(
                              userLocationData[0].latitude as double,
                              userLocationData[0].longitude as double,
                            ),
                            // tilt: 59.440717697143555,
                            zoom: 19.151926040649414,
                          ),
                          myLocationButtonEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (isStart && userLocationData.isNotEmpty)
                      appButttonWithoutAnimation(
                          context, CupertinoIcons.forward, 'End Trip',
                          () async {
                        var premission =
                            await _geolocatorPlatform.requestPermission();
                        print(
                            "This is the Premission record ${premission.name}");
                        // final Position positionFirst = await _determinePosition();

                        Location location = Location();
                        // location.enableBackgroundMode(enable: true);
                        LocationData _locationData;
                        _locationData = await location.getLocation();

                        userLocationData.add(UserLocation(
                          longitude: _locationData.longitude,
                          latitude: _locationData.latitude,
                        ));
                        userDateTime.add(DateTime.now());
                        _controller = Completer();
                        // final positionStream = _geolocatorPlatform.getPositionStream(
                        //     locationSettings: locationSettings);
                        // location.onLocationChanged.listen((LocationData currentLocation) {
                        //   // current user location
                        //   userLocationData.add(UserLocation(
                        //     longitude: currentLocation.longitude,
                        //     latitude: currentLocation.latitude,
                        //   ));
                        // });

                        setState(() {
                          isStart = false;
                        });
                      })
                  ],
                ),

                // floatingActionButton: FloatingActionButton.extended(
                //   onPressed: _goToTheLake,
                //   label: Text('To the lake!'),
                //   icon: Icon(Icons.directions_boat),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class TimePicker extends StatefulWidget {
//   final String hintText;
//   final TextEditingController timeController;
//   const TimePicker(
//       {Key? key, required this.hintText, required this.timeController})
//       : super(key: key);

//   @override
//   _TimePickerState createState() => _TimePickerState();
// }

// class _TimePickerState extends State<TimePicker> {
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed
//     widget.timeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: TextFormField(
//         readOnly: true,
//         controller: widget.timeController,
//         decoration: InputDecoration(
//           hintText: widget.hintText,
//           labelText: widget.hintText,
//         ),
//         onTap: () async {
//           var time = await showTimePicker(
//             initialTime: TimeOfDay.now(),
//             context: context,
//           );
//           if (time != null) {
//             widget.timeController.text = time.format(context);
//           }
//         },
//       ),
//     );
//   }
// }

