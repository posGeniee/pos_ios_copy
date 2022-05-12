import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/models/maintainance/part_order/part_order.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_field.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_category_edit_field.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

class UpdatePartOrderScreen extends StatefulWidget {
  static const routeName = '/UpdatePartOrderScreen';
  const UpdatePartOrderScreen({Key? key}) : super(key: key);

  @override
  _UpdatePartOrderScreenState createState() => _UpdatePartOrderScreenState();
}

class _UpdatePartOrderScreenState extends State<UpdatePartOrderScreen>
    with SingleTickerProviderStateMixin {
  final nameField = TextEditingController();

  final linkField = TextEditingController();
  final descriptionField = TextEditingController();
  final supplierField = TextEditingController();
  final categoryField = TextEditingController();
  var partCategoryDatum = PartCategoryDatum(
      id: 0,
      businessId: 0,
      locationId: "0",
      name: '',
      profit: '0',
      createdBy: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  String dropDownValue = 'None';
  changePartCategory(PartCategoryDatum userSelectedPartCategory) {
    partCategoryDatum = userSelectedPartCategory;
    setState(() {
      categoryField.text = partCategoryDatum.name;
    });
  }

  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args = ModalRoute.of(context)!.settings.arguments as PartOrderDatum;
    // print(args.name);

    nameField.text = args.orderName;
    linkField.text = args.link;
    descriptionField.text = args.description;
    supplierField.text = args.supplierName;
    categoryField.text = args.partCateName;
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
          "Update Part Order",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              showLoading();

              await Future.delayed(const Duration(seconds: 1));
              dismissLoading();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              edgeAlert(context,
                  gravity: Gravity.top,
                  title: 'Parts Updated Successfully',
                  backgroundColor: Colors.green);

              // bool validation = _formKey.currentState!.validate();
              // if (validation) {
              //   showLoading();
              //   final token = Provider.of<AuthRequest>(context, listen: false)
              //       .signiModelGetter
              //       .data!
              //       .bearer;
              //   final locationId =
              //       Provider.of<AuthRequest>(context, listen: false)
              //           .locationFromApiGetter
              //           .id;

              //   final modelDatum = PartCategoryDatum(
              //     name: nameField.text,
              //     id: args.id,
              //     businessId: args.businessId,
              //     locationId: args.locationId,
              //     createdAt: args.createdAt,
              //     createdBy: args.createdBy,
              //     profit: profitField.text,
              //     updatedAt: args.updatedAt,
              //   );
              //   final responseString =
              //       await MaintainanceApiFunction().updateCategoryPart(
              //     token,
              //     modelDatum,
              //     locationId.toString(),
              //   );

              //   if (responseString.runtimeType == PartCategoryDatum) {
              //     // Provider.of<MaintainanceProvider>(context, listen: false)
              //     //     .updateIndividualForMainScreebListModelDatumSetter(
              //     //         responseString);
              //     dismissLoading();
              //     Navigator.of(context).pop();
              //     Navigator.of(context).pop();
              //   } else {
              //     dismissLoading();
              //   }
              // }
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: UpdatePartOrderScreen.routeName,
        elevation: 0.0,
        child: const Icon(
          CupertinoIcons.delete_solid,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        onPressed: () {
          configureAlertOfApp(context, () async {
            showLoading();

            await Future.delayed(const Duration(seconds: 1));
            dismissLoading();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            edgeAlert(context,
                gravity: Gravity.top,
                title: 'Parts Deleted Successfully',
                backgroundColor: Colors.red);
          });
        },
      ),
      // floatingActionButton:

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    builder: (BuildContext _) {
                      return PartsCategoryEditFieldModelSheet(
                        categoryPartPicker: changePartCategory,
                      );
                    },
                    isScrollControlled: true,
                  );
                },
                controller: categoryField,
                decoration: const InputDecoration(
                  hintText: 'Select Part Category',
                  labelText: 'Parts Category : ',
                  suffixIcon: Icon(
                    Icons.search,
                    color: buttonColor,
                  ),
                ),
              ),
            ),
            newAppField(
                nameField, 'Name', TextInputType.name, [], TextInputAction.next,
                readOnly: false),
            newAppField(
                linkField, 'Link', TextInputType.name, [], TextInputAction.next,
                readOnly: false),
            newAppField(supplierField, 'Supplier', TextInputType.name, [],
                TextInputAction.next,
                readOnly: false),
            newAppField(descriptionField, 'Description', TextInputType.name, [],
                TextInputAction.next,
                readOnly: false),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  hintText: "Select the Status",
                ),
                value: dropDownValue,
                onChanged: (value) {
                  print("This si the Value Selected $value");
                },
                items: ['None', 'Yes', 'No']
                    .map(
                      (cityTitle) => DropdownMenuItem(
                        value: cityTitle,
                        child: Text(cityTitle),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
