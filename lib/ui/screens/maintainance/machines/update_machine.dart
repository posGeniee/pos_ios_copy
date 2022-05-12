import 'dart:io';

import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateMachineScreen extends StatefulWidget {
  static const routeName = '/UpdateMachineScreen';
  const UpdateMachineScreen({Key? key}) : super(key: key);

  @override
  _UpdateMachineScreenState createState() => _UpdateMachineScreenState();
}

class _UpdateMachineScreenState extends State<UpdateMachineScreen> {
  final numberField = TextEditingController();
  final nameField = TextEditingController();
  final temperature = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as MachineListModelDatum;
    numberField.text = args.number;
    nameField.text = args.name;
    temperature.text = args.temperature;
    args.displayUrl = '';
  }

  @override
  void initState() {
    initilizeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as MachineListModelDatum;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Update Machine",
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

                final modelDatum = MachineListModelDatum(
                    number: numberField.text,
                    name: nameField.text,
                    temperature: temperature.text,
                    id: args.id,
                    isSelected: false,
                    displayUrl:
                        (_userImageFile == null) ? '' : _userImageFile!.path);
                final responseString = await MaintainanceApiFunction()
                    .updateMachine(token, modelDatum);

                if (responseString.runtimeType == MachineListModelDatum) {
                  Provider.of<MaintainanceProvider>(context, listen: false)
                      .updateIndividualForMainScreebListModelDatumSetter(
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
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: const Icon(
          CupertinoIcons.delete_solid,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        onPressed: () {
          configureAlertOfApp(context, () async {
            showLoading();
            final token = Provider.of<AuthRequest>(context, listen: false)
                .signiModelGetter
                .data!
                .bearer;
            final responseString =
                await MaintainanceApiFunction().deleteMachine(args, token);
            if (responseString.runtimeType == String) {
              Provider.of<MaintainanceProvider>(context, listen: false)
                  .removeIndividualForMainScreebListModelDatumSetter(args);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            dismissLoading();
          });
        },
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
              newAppField(
                nameField,
                'Name',
                TextInputType.name,
                [],
                TextInputAction.next,
                readOnly: false,
              ),
              newAppField(
                temperature,
                'Temperature',
                TextInputType.name,
                [],
                TextInputAction.next,
                readOnly: false,
              ),

              // UserImagePicker(
              //   imagePickFn: _pickedImage,
              // ),

              // Text(_imageFileCamera!.path),
            ],
          ),
        ),
      ),
    );
  }
}
