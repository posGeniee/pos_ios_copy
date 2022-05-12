import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateCategoryParts extends StatefulWidget {
  static const routeName = '/UpdateCategoryParts';
  const UpdateCategoryParts({Key? key}) : super(key: key);

  @override
  _UpdateCategoryPartsState createState() => _UpdateCategoryPartsState();
}

class _UpdateCategoryPartsState extends State<UpdateCategoryParts> {
  final nameField = TextEditingController();

  final profitField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as PartCategoryDatum;
    print(args.name);

    nameField.text = args.name;
    profitField.text = args.profit;
  }

  @override
  void initState() {
    initilizeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PartCategoryDatum;
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
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;

                final modelDatum = PartCategoryDatum(
                  name: nameField.text,
                  id: args.id,
                  businessId: args.businessId,
                  locationId: args.locationId,
                  createdAt: args.createdAt,
                  createdBy: args.createdBy,
                  profit: profitField.text,
                  updatedAt: args.updatedAt,
                );
                final responseString =
                    await MaintainanceApiFunction().updateCategoryPart(
                  token,
                  modelDatum,
                  locationId.toString(),
                );

                if (responseString.runtimeType == PartCategoryDatum) {
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
        heroTag: UpdateCategoryParts.routeName,
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
            final responseString =
                await MaintainanceApiFunction().deletePartCategory(
              args,
              token,
              locationId.toString(),
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
