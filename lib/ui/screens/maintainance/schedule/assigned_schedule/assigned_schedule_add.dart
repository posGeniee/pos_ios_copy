import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/vendor_edit.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/assigned_schedule/assigned_model_customers.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddAssignedMachineScreen extends StatefulWidget {
  static const routeName = '/AddAssignedMachineScreen';
  const AddAssignedMachineScreen({Key? key}) : super(key: key);

  @override
  _AddAssignedMachineScreenState createState() =>
      _AddAssignedMachineScreenState();
}

class _AddAssignedMachineScreenState extends State<AddAssignedMachineScreen> {
  final customerField = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  void _doSomething1() async {
    var assigniId = Provider.of<MaintainanceProvider>(context, listen: false)
        .selectedCustomerListModelDatumGetter
        .id;
    _btnController1.start();
    if (assigniId == 0) {
      edgeAlert(
        context,
        title: 'Select the Asigni',
      );
      _btnController1.stop();
      return;
    }
    _btnController1.start();

    showLoading();

    final args =
        ModalRoute.of(context)!.settings.arguments as ScheduleModelDatum;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;

    final responseString = await MaintainanceApiFunction().addScheduleAsigni(
        args.id.toString(), token, locationId.toString(), assigniId.toString());

    dismissLoading();

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _doSomething2() async {
    var assigniId = Provider.of<ItemSearchProvider>(context, listen: false)
        .vendorSelectedGetter
        .id;
    _btnController2.start();
    if (assigniId == 0) {
      edgeAlert(
        context,
        title: 'Select the Vendor',
      );
      _btnController2.stop();
      return;
    }
    _btnController2.start();

    showLoading();

    final args =
        ModalRoute.of(context)!.settings.arguments as ScheduleModelDatum;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;

    final responseString = await MaintainanceApiFunction().addScheduleVendor(
        args.id.toString(), token, locationId.toString(), assigniId.toString());

    dismissLoading();

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    Provider.of<MaintainanceProvider>(context, listen: false)
        .emptySelectedCustomerListModelDatumSetter();
    super.initState();
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
          "Add Assigned Machine",
          style: Theme.of(context).textTheme.headline6,
        ),
        // actions: [
        //   appButttonWithoutAnimationWithoutDecoration(
        //     context,
        //     CupertinoIcons.share_up,
        //     'Save',
        //     () async {},
        //   ),
        // ],
      ),
      body: Column(
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
                    return const ModelSheetofCustomers();
                  },
                  isScrollControlled: true,
                );
              },
              controller: customerField,
              decoration: InputDecoration(
                hintText: data.fullName,
                labelText: 'Assigned to : ',
                suffixIcon: const Icon(
                  Icons.search,
                  color: buttonColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RoundedLoadingButton(
              height: 60,
              color: buttonColor,
              width: MediaQuery.of(context).size.width - 150,
              child: const Text(
                'Update Assign',
              ),
              controller: _btnController1,
              onPressed: _doSomething1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: VendorEditTextFormField(),
          ),
          Center(
            child: RoundedLoadingButton(
              height: 60,
              color: buttonColor,
              width: MediaQuery.of(context).size.width - 150,
              child: const Text(
                'Update Customer',
              ),
              controller: _btnController2,
              onPressed: _doSomething2,
            ),
          ),
        ],
      ),
    );
  }
}
