import 'dart:io';

import 'package:dummy_app/data/models/maintainance/schedule/notes/notes_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateNoteScreen extends StatefulWidget {
  static const routeName = '/UpdateNoteScreen';
  const UpdateNoteScreen({Key? key}) : super(key: key);

  @override
  _UpdateNoteScreenState createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final decriptionField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  initializeData() async {
    await Future.delayed(Duration.zero);
    final args = ModalRoute.of(context)!.settings.arguments as NotesModelDatum;
    decriptionField.text = args.description;
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //hello changes
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Update Note",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              final args =
                  ModalRoute.of(context)!.settings.arguments as NotesModelDatum;
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

                await MaintainanceApiFunction().updateNote(
                  token,
                  locationId.toString(),
                  args.id.toString(),
                  decriptionField.text,
                );
                dismissLoading();

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                // print(userDateTime.length);
                // if (userDateTime.length == 2) {
                //   edgeAlert(context,
                //       title: 'Kindly Start and End Trip then Save');
                // }
                // userDateTime = [];
                // userLocationData = [];
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: UpdateNoteScreen.routeName,
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
            final locationId = Provider.of<AuthRequest>(context, listen: false)
                .locationFromApiGetter
                .id;
            final args =
                ModalRoute.of(context)!.settings.arguments as NotesModelDatum;
            final responseString = await MaintainanceApiFunction().deleteNote(
              locationId.toString(),
              token,
              args.id.toString(),
            );
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            newAppField(decriptionField, 'Decription', TextInputType.name, [],
                TextInputAction.next,
                readOnly: false),

            // Text(_imageFileCamera!.path),
          ],
        ),
      ),
    );
  }
}
