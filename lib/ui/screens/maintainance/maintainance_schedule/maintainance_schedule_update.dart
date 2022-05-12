import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/notes/notes_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/maintainance_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/part_main_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_main.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MaintainanceScheduleUpdate extends StatefulWidget {
  static const routeName = '/MaintainanceScheduleUpdate';
  const MaintainanceScheduleUpdate({Key? key}) : super(key: key);

  @override
  _MaintainanceScheduleUpdateState createState() =>
      _MaintainanceScheduleUpdateState();
}

class _MaintainanceScheduleUpdateState
    extends State<MaintainanceScheduleUpdate> {
  final costField = TextEditingController();
  final descriptionField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as ScheduleModelDatum;
    print(args.machine);

    costField.text = args.cost;
    descriptionField.text = args.desc;
  }

  @override
  void initState() {
    initilizeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScheduleModelDatum;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Edit Schedule",
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

                final responseString = await MaintainanceApiFunction()
                    .updateScheduleCostandDescription(
                  token,
                  args.id.toString(),
                  locationId.toString(),
                  costField.text,
                  descriptionField.text,
                );

                if (responseString.runtimeType == ScheduleModelDatum) {
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              newAppField(
                  costField,
                  'Cost',
                  TextInputType.number,
                  [FilteringTextInputFormatter.digitsOnly],
                  TextInputAction.next,
                  readOnly: false),
              newAppField(descriptionField, 'Description', TextInputType.name,
                  [], TextInputAction.next,
                  readOnly: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  appButttonWithoutAnimation(
                    context,
                    CupertinoIcons.eyedropper,
                    'Ticket Trips',
                    () {
                      Navigator.of(context)
                          .pushNamed(TicketTripMain.routeName, arguments: args);
                    },
                  ),
                  appButttonWithoutAnimation(
                    context,
                    CupertinoIcons.eyedropper,
                    'Notes',
                    () {
                      Navigator.of(context).pushNamed(
                        NoteMainScreen.routeName,
                        arguments: args,
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: appButttonWithoutAnimation(
                  context,
                  CupertinoIcons.eyedropper,
                  'Parts',
                  () {
                    Navigator.of(context).pushNamed(
                      MaintainanceMainWhenSchedule.routeName,
                      arguments: args,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
