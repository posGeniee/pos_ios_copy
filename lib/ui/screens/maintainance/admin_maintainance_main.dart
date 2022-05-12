import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/ui/screens/maintainance/machines/machine_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/maintainance_schedule_main.dart';
import 'package:dummy_app/ui/screens/maintainance/parts/parts_main.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_category/parts_category_main.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_main.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/assigned_schedule/assigned_schedule_main.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/schedule_main.dart';
import 'package:dummy_app/ui/screens/maintainance/temperature/temperature_main.dart';
import 'package:flutter/material.dart';

class AdminMainMaintainance extends StatefulWidget {
  static const routeName = '/AdminMainMaintainance';
  const AdminMainMaintainance({Key? key}) : super(key: key);

  @override
  _AdminMainMaintainanceState createState() => _AdminMainMaintainanceState();
}

class _AdminMainMaintainanceState extends State<AdminMainMaintainance> {
  // List<int> text = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    // return AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: SystemUiOverlayStyle(
    //       statusBarColor: buttonColor,
    //       statusBarIconBrightness: Brightness.light),
    //   child: SafeArea(
    //

    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(
              "Admin Dashboard",
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
                  text: 'Machines',
                ),
                Tab(
                  text: 'Parts',
                ),
                Tab(
                  text: 'Part Category',
                ),
                Tab(
                  text: 'Part Orders',
                ),
                Tab(
                  text: 'Temperature',
                ),
                Tab(
                  text: 'Schedule',
                ),
                Tab(
                  text: 'Assigned Schedule',
                ),
                Tab(
                  text: 'Maintainance Schedule',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MachineMainScreen(),
              PartsMainScreen(),
              PartsCategoryMainScreen(),
              PartsOrderMainScreen(
                showAppBar: false,
              ),
              TemperatureMainScreen(),
              ScheduleMainScreen(),
              AssignedMainMachine(),
              MaintainanceScheduleMain(),
            ],
          ),
        ),
      ),
    );
  }
}
