import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/models/maintainance/part_order/part_order.dart';
import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPartOrderWhenSchedule extends StatefulWidget {
  static const routeName = '/AddPartOrderWhenSchedule';
  const AddPartOrderWhenSchedule({Key? key}) : super(key: key);

  @override
  _AddPartOrderWhenScheduleState createState() =>
      _AddPartOrderWhenScheduleState();
}

class _AddPartOrderWhenScheduleState extends State<AddPartOrderWhenSchedule> {
  final nameField = TextEditingController();
  final dateField = TextEditingController();

  final linkField = TextEditingController();
  final descriptionField = TextEditingController();
  final supplierField = TextEditingController();
  final categoryField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              bool validation = _formKey.currentState!.validate();
              if (validation && partCategoryDatum.id != 0) {
                showLoading();
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;
                final args = ModalRoute.of(context)!.settings.arguments
                    as ScheduleModelDatum;
                // final modelDatum = PartsListModelDatum(
                //     name: nameField.text,
                //     note: costField.text,
                //     image: '',
                //     id: 0,
                //     displayUrl:
                //         (_userImageFile == null) ? '' : _userImageFile!.path);
                final responseString = await MaintainanceApiFunction()
                    .addPartsOrderWhenSchedule(
                        token,
                        locationId.toString(),
                        partCategoryDatum.id.toString(),
                        dateField.text,
                        nameField.text,
                        linkField.text,
                        supplierField.text,
                        descriptionField.text,
                        dropDownValue.contains("None") ||
                                dropDownValue.contains("No")
                            ? "0"
                            : "1",
                        args.id.toString());

                if (responseString.runtimeType == PartOrderDatum) {
                  // Provider.of<MaintainanceProvider>(context, listen: false)
                  //     .addIndividualForMainScreebListModelDatumSetter(
                  //         responseString);
                  dismissLoading();

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  dismissLoading();
                }
              } else {
                edgeAlert(
                  context,
                  title: 'Part Field Missing',
                );
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
              newAppField(nameField, 'Name', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(linkField, 'Link', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(supplierField, 'Supplier', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DateTimeField(
                  controller: dateField,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Date';
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter Recieve Date',
                      label: Text('Recieve Date')),
                  format: formatofDateForViewwithTime,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                ),
              ),
              newAppField(descriptionField, 'Description', TextInputType.name,
                  [], TextInputAction.next,
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
      ),
    );
  }
}
