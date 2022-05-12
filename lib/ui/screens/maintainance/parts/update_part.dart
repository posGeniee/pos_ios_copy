import 'dart:io';

import 'package:dummy_app/data/models/maintainance/parts/parts_model_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePartScreen extends StatefulWidget {
  static const routeName = '/UpdatePartScreen';
  const UpdatePartScreen({Key? key}) : super(key: key);

  @override
  _UpdatePartScreenState createState() => _UpdatePartScreenState();
}

class _UpdatePartScreenState extends State<UpdatePartScreen> {
  final nameField = TextEditingController();
  final noteField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as PartsListModelDatum;
    print(args.name);

    nameField.text = args.name;
    noteField.text = args.note;
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
        ModalRoute.of(context)!.settings.arguments as PartsListModelDatum;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Update Part",
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

                final modelDatum = PartsListModelDatum(
                    name: nameField.text,
                    id: args.id,
                    image: '',
                    note: noteField.text,
                    displayUrl:
                        (_userImageFile == null) ? '' : _userImageFile!.path);
                final responseString =
                    await MaintainanceApiFunction().updateParts(
                  token,
                  modelDatum,
                  locationId.toString(),
                );

                if (responseString.runtimeType == PartsListModelDatum) {
                  // Provider.of<MaintainanceProvider>(context, listen: false)
                  //     .updateIndividualForMainScreebListModelDatumSetter(
                  //         responseString);
                  dismissLoading();
                  Navigator.of(context).pop();
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
                await MaintainanceApiFunction().deletePart(args, token);
            if (responseString.runtimeType == String) {
              // Provider.of<MaintainanceProvider>(context, listen: false)
              //     .removeIndividualForMainScreebListModelDatumSetter(args);
              Navigator.of(context).pop();
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
              newAppField(nameField, 'Name', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(
                noteField,
                'Note',
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
