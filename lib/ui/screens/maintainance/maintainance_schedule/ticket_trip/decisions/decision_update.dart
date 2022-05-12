import 'dart:io';

import 'package:dummy_app/data/models/maintainance/schedule/trips/decision/decision_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateDecisionScreen extends StatefulWidget {
  static const routeName = '/UpdateDecisionScreen';
  const UpdateDecisionScreen({Key? key}) : super(key: key);

  @override
  _UpdateDecisionScreenState createState() => _UpdateDecisionScreenState();
}

class _UpdateDecisionScreenState extends State<UpdateDecisionScreen> {
  final decriptionField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as DecisionModelDatum;

    decriptionField.text = args.description;
    // costField.text = args.reportFullPath.cost;
  }

  @override
  void initState() {
    initilizeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Update Decision",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              final args = ModalRoute.of(context)!.settings.arguments
                  as DecisionModelDatum;
              bool validation = _formKey.currentState!.validate();
              if (validation) {
                showLoading();
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;

                await MaintainanceApiFunction().updateTripDescision(
                  token,
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
        heroTag: UpdateDecisionScreen.routeName,
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
            final args = ModalRoute.of(context)!.settings.arguments
                as DecisionModelDatum;
            // print(args.reportFullPath.id.toString());
            final responseString =
                await MaintainanceApiFunction().deleteTripDescision(
              args.id.toString(),
              token,
            );
            if (responseString.runtimeType == String) {
              // Provider.of<MaintainanceProvider>(context, listen: false)
              //     .removeIndividualForMainScreebListModelDatumSetter(
              //         args);
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
              newAppField(decriptionField, 'Decription', TextInputType.number,
                  [], TextInputAction.next,
                  readOnly: false),

              // Text(_imageFileCamera!.path),
            ],
          ),
        ),
      ),
    );
  }
}
