import 'dart:io';

import 'package:dummy_app/data/models/maintainance/parts/parts_model_list.dart';
import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_field.dart';
import 'package:dummy_app/ui/screens/maintainance/widgets/part_edit_field.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PartsMainAddScreenWhenScedule extends StatefulWidget {
  static const routeName = '/PartsMainAddScreenWhenScedule';
  const PartsMainAddScreenWhenScedule({Key? key}) : super(key: key);

  @override
  _PartsMainAddScreenWhenSceduleState createState() =>
      _PartsMainAddScreenWhenSceduleState();
}

class _PartsMainAddScreenWhenSceduleState
    extends State<PartsMainAddScreenWhenScedule> {
  final nameField = TextEditingController();
  final partField = TextEditingController();
  final costField = TextEditingController();
  final dateField = TextEditingController();

  final descriptionField = TextEditingController();
  File? _userImageFile;
  void Function(File)? _pickedImage(File image) {
    _userImageFile = image;
  }

  final _formKey = GlobalKey<FormState>();
  PartsListModelDatum? partOrderDatum;
  changePartCategory(PartsListModelDatum? userSelectedPartCategory) {
    setState(() {
      partOrderDatum = userSelectedPartCategory;
      partField.text = partOrderDatum!.name;
    });
  }

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
              if (validation && partOrderDatum != null) {
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
                final responseString =
                    await MaintainanceApiFunction().addPartWhenSchedule(
                  token,
                  locationId.toString(),
                  args.id.toString(),
                  partOrderDatum!.id.toString(),
                  dateField.text,
                  descriptionField.text,
                  costField.text,
                  '0',
                );

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
                        return PartsEditFieldModelSheet(
                          categoryPartPicker: changePartCategory,
                          partsListModelDatum:
                              (partOrderDatum == null) ? null : partOrderDatum,
                        );
                      },
                      isScrollControlled: true,
                    );
                  },
                  controller: partField,
                  decoration: const InputDecoration(
                    hintText: 'Add Part',
                    labelText: 'Part',
                    suffixIcon: Icon(
                      Icons.search,
                      color: buttonColor,
                    ),
                  ),
                ),
              ),
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
                      hintText: 'Enter Date', label: Text('Date')),
                  format: formatofDateForViewwithTimeSlash,
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
              newAppField(nameField, 'Name', TextInputType.name, [],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(
                descriptionField,
                'Description',
                TextInputType.name,
                [],
                TextInputAction.next,
                readOnly: false,
              ),
              newAppField(
                costField,
                'Cost',
                TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly],
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
