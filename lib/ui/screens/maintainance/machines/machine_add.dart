import 'dart:io';

import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMachineScreen extends StatefulWidget {
  static const routeName = '/AddMachineScreen';
  const AddMachineScreen({Key? key}) : super(key: key);

  @override
  _AddMachineScreenState createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  final numberField = TextEditingController();
  final nameField = TextEditingController();
  final temperature = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Machine",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              bool validation = _formKey.currentState!.validate();
              if (validation) {
                showLoading();
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;
                final modelDatum = MachineListModelDatum(
                    number: numberField.text,
                    name: nameField.text,
                    temperature: temperature.text,
                    id: 0,
                    isSelected: false,
                    displayUrl:
                        (_userImageFile == null) ? '' : _userImageFile!.path);
                final responseString = await MaintainanceApiFunction()
                    .addMachine(token, locationId.toString(), modelDatum);

                if (responseString.runtimeType == MachineListModelDatum) {
                  Provider.of<MaintainanceProvider>(context, listen: false)
                      .addIndividualForMainScreebListModelDatumSetter(
                          responseString);
                  dismissLoading();

                  Navigator.of(context).pop();
                } else {
                  dismissLoading();
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              newAppField(
                  numberField,
                  'Number',
                  TextInputType.number,
                  [FilteringTextInputFormatter.digitsOnly],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(nameField, 'Name', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(
                temperature,
                'Temperature',
                TextInputType.number,
                [],
                TextInputAction.next,
                readOnly: false,
              ),
              UserImagePicker(
                imagePickFn: _pickedImage,
              ),

              // Text(_imageFileCamera!.path),
            ],
          ),
        ),
      ),
    );
  }
}
