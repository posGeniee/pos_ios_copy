import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/models/maintainance/schedule/trips/trip_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/decisions/decisions_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_add.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateTicketTrip extends StatefulWidget {
  static const routeName = '/UpdateTicketTrip';
  const UpdateTicketTrip({Key? key}) : super(key: key);

  @override
  _UpdateTicketTripState createState() => _UpdateTicketTripState();
}

class _UpdateTicketTripState extends State<UpdateTicketTrip>
    with SingleTickerProviderStateMixin {
  final decriptionField = TextEditingController();
  final startPoint = TextEditingController();
  final endPoint = TextEditingController();
  final costField = TextEditingController();
  final startTimeField = TextEditingController();
  final endTimeField = TextEditingController();

  late Animation<double> _animation;
  late AnimationController _animationController;
  final _formKey = GlobalKey<FormState>();
  initilizeData() async {
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as DoubleScreenArguments;

    decriptionField.text = args.reportFullPath.description;
    costField.text = args.reportFullPath.cost;
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    initilizeData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Add Trip",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              final args = ModalRoute.of(context)!.settings.arguments
                  as DoubleScreenArguments;
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

                await MaintainanceApiFunction().updateScheduleTrip(
                  args.reportTitle.id.toString(),
                  token,
                  locationId.toString(),
                  args.reportFullPath.startTime,
                  args.reportFullPath.endTime,
                  '37.4219983:-122.084',
                  '37.4219983:-122.084',
                  decriptionField.text,
                  costField.text,
                  args.reportFullPath.id.toString(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      //Init Floating Action Bubble
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: "Delete",
              iconColor: Colors.red,
              bubbleColor: buttonColor,
              icon: Icons.delete,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                final args = ModalRoute.of(context)!.settings.arguments
                    as DoubleScreenArguments;
                _animationController.reverse();
                configureAlertOfApp(context, () async {
                  showLoading();
                  final token = Provider.of<AuthRequest>(context, listen: false)
                      .signiModelGetter
                      .data!
                      .bearer;
                  print(args.reportFullPath.id.toString());
                  final responseString =
                      await MaintainanceApiFunction().deleteTrip(
                    args.reportFullPath.id.toString(),
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
            //Floating action menu item
            Bubble(
              title: "Decisions",
              iconColor: Colors.white,
              bubbleColor: buttonColor,
              icon: Icons.description,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                final args = ModalRoute.of(context)!.settings.arguments
                    as DoubleScreenArguments;
                _animationController.reverse();
                Navigator.of(context).pushNamed(
                  DecisionMainScreen.routeName,
                  arguments: args.reportFullPath,
                );
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.white,

          // Flaoting Action button Icon
          iconData: Icons.edit,
          backGroundColor: buttonColor,
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TimePicker(
              //   hintText: 'Start Time',
              //   timeController: startTimeField,
              // ),
              // TimePicker(
              //   hintText: 'End Time',
              //   timeController: endTimeField,
              // ),
              newAppField(decriptionField, 'Description', TextInputType.number,
                  [], TextInputAction.next,
                  readOnly: false),
              // newAppField(startPoint, 'Start Point', TextInputType.name, [],
              //     TextInputAction.next,
              //     readOnly: false),
              // newAppField(
              //   endPoint,
              //   'End Point',
              //   TextInputType.name,
              //   [],
              //   TextInputAction.next,
              //   readOnly: false,
              // ),
              newAppField(
                costField,
                'Cost',
                TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly],
                TextInputAction.next,
                readOnly: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoubleScreenArguments {
  final ScheduleModelDatum reportTitle;
  final dynamic reportFullPath;

  DoubleScreenArguments(this.reportTitle, this.reportFullPath);
}
