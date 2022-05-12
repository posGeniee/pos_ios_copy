import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/part_main_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/part_order_main_when_schedule.dart';

import 'package:flutter/material.dart';

class MaintainanceMainWhenSchedule extends StatefulWidget {
  static const routeName = '/MaintainanceMainWhenSchedule';
  const MaintainanceMainWhenSchedule({Key? key}) : super(key: key);

  @override
  _MaintainanceMainWhenScheduleState createState() =>
      _MaintainanceMainWhenScheduleState();
}

class _MaintainanceMainWhenScheduleState
    extends State<MaintainanceMainWhenSchedule> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScheduleModelDatum;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "Maintainance When Schedule",
            style: Theme.of(context).textTheme.headline6,
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: buttonColor,
            labelColor: Colors.black,
            unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
            labelStyle:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            tabs: const <Widget>[
              Tab(
                text: 'Parts',
              ),
              Tab(
                text: 'Part Order',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PartMainScreenWhenSchedule(
              args: args,
            ),
            PartsOrderMainScreenWhenSchedule(
              args: args,
            ),
          ],
        ),
      ),
    );
  }
}
