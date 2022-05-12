import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  static const routeName = '/AddNote';
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final decriptionField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Note",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              final args = ModalRoute.of(context)!.settings.arguments
                  as ScheduleModelDatum;
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

                await MaintainanceApiFunction().addNote(
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              newAppField(decriptionField, 'Decription', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
            ],
          ),
        ),
      ),
    );
  }
}
