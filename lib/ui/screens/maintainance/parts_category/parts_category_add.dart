import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddPartCategoryScreen extends StatefulWidget {
  static const routeName = '/AddPartCategoryScreen';
  const AddPartCategoryScreen({Key? key}) : super(key: key);

  @override
  _AddPartCategoryScreenState createState() => _AddPartCategoryScreenState();
}

class _AddPartCategoryScreenState extends State<AddPartCategoryScreen> {
  final nameField = TextEditingController();
  final profitField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Part Category",
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
                final modelDatum = PartCategoryDatum(
                  name: nameField.text,
                  id: 0,
                  businessId: 0,
                  locationId: "0",
                  createdAt: DateTime.now(),
                  createdBy: 0,
                  profit: profitField.text,
                  updatedAt: DateTime.now(),
                );
                final responseString = await MaintainanceApiFunction()
                    .addPartCategory(token, locationId.toString(), modelDatum);

                if (responseString.runtimeType == PartCategoryDatum ) {
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            newAppField(
                nameField, 'Name', TextInputType.name, [], TextInputAction.next,
                readOnly: false),
            newAppField(profitField, 'Profit', TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly], TextInputAction.next,
                readOnly: false),
          ],
        ),
      ),
    );
  }
}
