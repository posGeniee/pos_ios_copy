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

class PartsMainAddScreen extends StatefulWidget {
  static const routeName = '/PartsMainAddScreen';
  const PartsMainAddScreen({Key? key}) : super(key: key);

  @override
  _PartsMainAddScreenState createState() => _PartsMainAddScreenState();
}

class _PartsMainAddScreenState extends State<PartsMainAddScreen> {
  final nameField = TextEditingController();
  final noteField = TextEditingController();
  File? _userImageFile;
  void Function(File)? _pickedImage(File image) {
    _userImageFile = image;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Part",
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
                    note: noteField.text,
                    image: '',
                    id: 0,
                    displayUrl:
                        (_userImageFile == null) ? '' : _userImageFile!.path);
                final responseString = await MaintainanceApiFunction()
                    .addPart(token, locationId.toString(), modelDatum);

                if (responseString.runtimeType == PartsListModelDatum) {
                  // Provider.of<MaintainanceProvider>(context, listen: false)
                  //     .addIndividualForMainScreebListModelDatumSetter(
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
            ],
          ),
        ),
      ),
    );
  }
}
