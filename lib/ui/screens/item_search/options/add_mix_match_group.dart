import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMixMatchGroup extends StatefulWidget {
  static const routeName = '/AddMixMatchGroup';
  const AddMixMatchGroup({Key? key}) : super(key: key);

  @override
  _AddMixMatchGroupState createState() => _AddMixMatchGroupState();
}

class _AddMixMatchGroupState extends State<AddMixMatchGroup> {
  final nameField = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Mix Match Group",
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

                final responseString = await ItemSearchApiFuncion()
                    .addMixMatchGroup(
                        nameField.text, locationId.toString(), token);

                if (responseString.runtimeType == String) {
                  // Provider.of<MaintainanceProvider>(context, listen: false)
                  //     .addIndividualForMainScreebListModelDatumSetter(
                  //         responseString);
                  dismissLoading();

                  Navigator.of(context).pop();
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

              // Text(_imageFileCamera!.path),
            ],
          ),
        ),
      ),
    );
  }
}
