import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/models/maintainance/temperature/temperature_model_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/machine_text_form_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:edge_alerts/edge_alerts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMachineTemperature extends StatefulWidget {
  static const routeName = '/AddMachineTemperature';
  const AddMachineTemperature({Key? key}) : super(key: key);

  @override
  _AddMachineTemperatureState createState() => _AddMachineTemperatureState();
}

class _AddMachineTemperatureState extends State<AddMachineTemperature> {
  final datefield = TextEditingController();
  // final nameField = TextEditingController();
  final temperature = TextEditingController();
  MachineListModelDatum? _userMachineSelected;
  void _pickedMachine(MachineListModelDatum machineListModelDatum) {
    _userMachineSelected = machineListModelDatum;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Temperature",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              bool validation = _formKey.currentState!.validate();
              if (validation && _userMachineSelected != null) {
                showLoading();
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;

                // final modelDatum = TemperatureModelDatum(
                //   machine: _userMachineSelected.id.toString(),
                //   date: datefield.text,
                // );
                final responseString = await MaintainanceApiFunction()
                    .addTemperature(
                        token,
                        locationId.toString(),
                        _userMachineSelected!.id.toString(),
                        datefield.text,
                        temperature.text);

                if (responseString.runtimeType == TemperatureModelDatum) {
                  // Provider.of<MaintainanceProvider>(context, listen: false)
                  //     .addIndividualForMainScreebListModelDatumSetter(
                  //         responseString);
                  dismissLoading();

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  dismissLoading();
                }
              } else {
                edgeAlert(
                  context,
                  title: 'Select the Machine',
                  backgroundColor: Colors.red
                );
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: MachineEditTextFormField(
                pickedMachineFn: _pickedMachine,
              ),
            ),
            newAppField(temperature, 'Temperature', TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly], TextInputAction.next,
                readOnly: false),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DateTimeField(
                controller: datefield,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter Date';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter Date', label: Text('Date')),
                format: formatofDateForViewwithTime,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),

            // Text(_imageFileCamera!.path),
          ],
        ),
      ),
    );
  }
}
