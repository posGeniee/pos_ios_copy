import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/ui/screens/maintainance/admin_maintainance_main.dart';
import 'package:dummy_app/ui/screens/maintainance/equipment_main.dart';
import 'package:dummy_app/ui/screens/maintainance/event_page.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/maintainance_schedule_main.dart';

import 'package:dummy_app/ui/screens/maintainance/schedule/assigned_schedule/assigned_schedule_main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaintainanceMain extends StatefulWidget {
  static const routeName = '/MaintainanceMain';
  const MaintainanceMain({Key? key}) : super(key: key);

  @override
  _MaintainanceMainState createState() => _MaintainanceMainState();
}

class _MaintainanceMainState extends State<MaintainanceMain> {
  List<int> text = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: buttonColor,
          statusBarIconBrightness: Brightness.light),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: buttonColor,
                  ),
                  child: Center(
                    child: Text(
                      'Maintainance',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Dashboard',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: buttonColor),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Orders',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: buttonColor),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MaintainanceScheduleMain(
                          title: 'Schedule Orders',
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Equipment',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: buttonColor),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EquipmentMaintainanceMain(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Admin Operations',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: buttonColor),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminMainMaintainance(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'View Calender',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: buttonColor),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                    // Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Exit Maintainance',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: buttonColor),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                    Navigator.pop(context);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AdminMainMaintainance(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: buttonColor,
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ));
            }),
            title: Text(
              "Maintainance Dashboard",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 280,
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        color: buttonColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            height: 280,
                            decoration: new BoxDecoration(
                              color: Colors
                                  .white, //new Color.fromRGBO(255, 0, 0, 0.0),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Summary',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              ListTile(
                                title: Text('Current Order'),
                                trailing: Text('10'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AssignedMainMachine(
                                        title: 'Current Orders',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('Pending Order'),
                                trailing: Text('20'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AssignedMainMachine(
                                        title: 'Pending Order',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('Completed orders'),
                                trailing: Text('30'),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const AssignedMainMachine(
                                  //       title: 'Completed Orders',
                                  //     ),
                                  //   ),
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MaintainanceScheduleMain(
                                        title: 'Completed Orders',
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('Schedule orders'),
                                trailing: Text('30'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MaintainanceScheduleMain(
                                        title: 'Schedule Orders',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'History By Technicians',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                for (var i in text)
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Image.network(
                        'https://www.seekpng.com/png/full/60-604032_face-businessman-png-dummy-images-for-testimonials.png',
                        fit: BoxFit.fill,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Name : ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Test Tech',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Completed Job : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '10'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Pending Job : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '5'),
                            ],
                          ),
                        ),
                        Divider(),

                        // RichText(
                        //   text: TextSpan(
                        //     text: '',
                        //     style: DefaultTextStyle.of(context).style,
                        //     children: <TextSpan>[
                        //       const TextSpan(
                        //           text: 'In Process Job : ',
                        //           style: TextStyle(fontWeight: FontWeight.bold)),
                        //       TextSpan(text: ''),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 18),
                //   child: Card(
                //     elevation: 3,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Container(
                //       height: 225,
                //       decoration: new BoxDecoration(
                //         color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                //         borderRadius: new BorderRadius.all(
                //           Radius.circular(10),
                //         ),
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.stretch,
                //         children: [

                //         // ListTile(
                //         //   title: Text('Current Order'),
                //         //   trailing: Text('10'),
                //         // ),
                //         // ListTile(
                //         //   title: Text('Pending Order'),
                //         //   trailing: Text('20'),
                //         // ),
                //         // ListTile(
                //         //   title: Text('Completed orders'),
                //         //   trailing: Text('30'),
                //         // ),
                //         // ListTile(
                //         //   title: Text('Sceduled orders'),
                //         //   trailing: Text('30'),
                //         // ),
                //       ]),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    // DefaultTabController(
    //   initialIndex: 0,
    //   length: 8,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       elevation: 1,
    //       title: Text(
    //         "Maintainance Dashboard",
    //         style: Theme.of(context).textTheme.headline6,
    //       ),
    //       // bottom: TabBar(
    //       //   isScrollable: true,
    //       //   indicatorColor: buttonColor,
    //       //   labelColor: Colors.black,
    //       //   unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
    //       //   labelStyle:
    //       //       Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
    //       //   tabs: const <Widget>[
    //       //     Tab(
    //       //       text: 'Machines',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Parts',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Part Category',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Part Orders',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Temperature',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Schedule',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Assigned Schedule',
    //       //     ),
    //       //     Tab(
    //       //       text: 'Maintainance Schedule',
    //       //     ),
    //       //   ],
    //       // ),
    //     ),
    //     body: Text("Data"),
    //     // Column(children: [
    //     //   Container(
    //     //     padding: EdgeInsets.only(left: 0.0, bottom: 8.0, right: 16.0),
    //     //     decoration: BoxDecoration(color: buttonColor),
    //     //     child: Column(
    //     //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //     //         mainAxisSize: MainAxisSize.min,
    //     //         mainAxisAlignment: MainAxisAlignment.center,
    //     //         children: [
    //     //           Text(
    //     //             '',
    //     //             style: TextStyle(
    //     //                 color: Colors.white,
    //     //                 fontSize: 26.0,
    //     //                 fontWeight: FontWeight.bold),
    //     //             textAlign: TextAlign.center,
    //     //           ),
    //     //           Text(
    //     //             'Dashboard',
    //     //             style: TextStyle(
    //     //                 color: Colors.white,
    //     //                 fontSize: 26.0,
    //     //                 fontWeight: FontWeight.bold),
    //     //             textAlign: TextAlign.center,
    //     //           ),
    //     //           Text(
    //     //             '',
    //     //             style: TextStyle(
    //     //                 color: Colors.white,
    //     //                 fontSize: 26.0,
    //     //                 fontWeight: FontWeight.bold),
    //     //             textAlign: TextAlign.center,
    //     //           ),
    //     //         ]),
    //     //   ),
    //     //   // Card(
    //     //   //   child: Column(
    //     //   //     children: <Widget>[
    //     //   //       Text('Order'),
    //     //   //       // Image.network(
    //     //   //       //     'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),

    //     //   //       // Padding(
    //     //   //       //     padding: EdgeInsets.all(7.0),
    //     //   //       //     child: Row(
    //     //   //       //       children: <Widget>[
    //     //   //       //         Padding(
    //     //   //       //           padding: EdgeInsets.all(7.0),
    //     //   //       //           child: Icon(Icons.thumb_up),
    //     //   //       //         ),
    //     //   //       //         Padding(
    //     //   //       //           padding: EdgeInsets.all(7.0),
    //     //   //       //           child: Text(
    //     //   //       //             'Like',
    //     //   //       //             style: TextStyle(fontSize: 18.0),
    //     //   //       //           ),
    //     //   //       //         ),
    //     //   //       //         Padding(
    //     //   //       //           padding: EdgeInsets.all(7.0),
    //     //   //       //           child: Icon(Icons.comment),
    //     //   //       //         ),
    //     //   //       //         Padding(
    //     //   //       //           padding: EdgeInsets.all(7.0),
    //     //   //       //           child: Text('Comments',
    //     //   //       //               style: TextStyle(fontSize: 18.0)),
    //     //   //       //         )
    //     //   //       //       ],
    //     //   //       //     )),

    //     //   //     ],
    //     //   //   ),
    //     //   // ),
    //     // ])
    //     // // FirstFragment(),

    //     // const TabBarView(
    //     //   children: [
    //     //     MachineMainScreen(),
    //     //     PartsMainScreen(),
    //     //     PartsCategoryMainScreen(),
    //     //     PartsOrderMainScreen(
    //     //       showAppBar: false,
    //     //     ),
    //     //     TemperatureMainScreen(),
    //     //     ScheduleMainScreen(),
    //     //     AssignedMainMachine(),
    //     //     MaintainanceScheduleMain(),
    //     //   ],
    //     // ),
    //   ),
    // );
  }
}
