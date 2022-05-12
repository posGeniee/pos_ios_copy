import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_field.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_category_edit_field.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddPartOrderScreen extends StatefulWidget {
  static const routeName = '/AddPartOrderScreen';
  const AddPartOrderScreen({Key? key}) : super(key: key);

  @override
  _AddPartOrderScreenState createState() => _AddPartOrderScreenState();
}

class _AddPartOrderScreenState extends State<AddPartOrderScreen> {
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

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MaintainanceProvider>(
      context,
    ).selectedCustomerListModelDatumGetter;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Part Order",
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
                  title: 'Parts Added Successfully',
                  backgroundColor: Colors.green);
            },
          ),
        ],
      ),
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
                decoration: InputDecoration(
                  hintText: data.fullName,
                  labelText: 'Parts Category : ',
                  suffixIcon: const Icon(
                    Icons.search,
                    color: buttonColor,
                  ),
                ),
              ),
            ),
            newAppField(nameField, 'Name', TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly], TextInputAction.next,
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
