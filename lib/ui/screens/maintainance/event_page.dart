import 'package:dummy_app/data/models/maintainance/ui_model/calender_event.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/src/cell_calendar.dart';
// import 'package:app_office_1/const.dart';
// import 'package:app_office_1/library/cell_calendar-master/src/cell_calendar.dart';
// import 'package:app_office_1/state_management/event_provider.dart';
// import 'package:app_office_1/state_management/models/event_api_model.dart';
// import 'package:app_office_1/state_management/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventPage extends StatelessWidget {
  static const routeName = '/EventPage';
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "Calender View",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Column(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.3,
            //   child: Image.asset(
            //     'assets/images/event_page.png',
            //     fit: BoxFit.fill,
            //   ),
            // ),
            // Expanded(child: Container()),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              margin: const EdgeInsets.all(10),
              child: CalenderView(),
            ),
            Expanded(child: Container()),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

class CalenderView extends StatefulWidget {
  const CalenderView({Key? key}) : super(key: key);

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  late List<CalendarEvent> events = [];
  var isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    MaintainanceApiFunction()
        .viewCalender(token, locationId.toString())
        .then((value) {
      EventModel data = eventModelFromMap(value);
      data.data.map((e) {
        events.add(
          CalendarEvent(
            eventName: e.title,
            eventDate: DateTime(e.start!.year, e.start!.month, e.start!.day),
            eventBackgroundColor: colorpink,
            eventTextColor: Colors.white,
          ),
        );
      }).toList();
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cellCalendarPageController = CellCalendarPageController();
    return isLoading
        ? SizedBox(
            height: 500,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: colorblue,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.5)),
                strokeWidth: 1.5,
              ),
            ),
          )
        : CellCalendar(
            cellCalendarPageController: cellCalendarPageController,
            events: events,
            dateTextStyle: TextStyle(
              color: const Color.fromRGBO(48, 48, 48, 1),
              // fontFamily: heeboFontFamily,
            ),
            daysOfTheWeekBuilder: (dayIndex) {
              final labels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sun"];
              return Container(
                color: (dayIndex == 0 || dayIndex == 6)
                    ? colorblue
                    : colorblue.withOpacity(0.14),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    labels[dayIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      // fontFamily: heeboFontFamily,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            monthYearLabelBuilder: (datetime) {
              final year = datetime!.year.toString();
              final month = datetime.month.monthName;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      "$month  $year",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        cellCalendarPageController.animateToDate(
                          DateTime.now(),
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 300),
                        );
                      },
                    )
                  ],
                ),
              );
            },
            onCellTapped: (date) {
              final eventsOnTheDate = events.where((event) {
                final eventDate = event.eventDate;
                return eventDate.year == date.year &&
                    eventDate.month == date.month &&
                    eventDate.day == date.day;
              }).toList();
              if (eventsOnTheDate.isNotEmpty)
                // ignore: curly_braces_in_flow_control_structures
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(
                              date.month.monthName + " " + date.day.toString()),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: eventsOnTheDate
                                .map(
                                  (event) => Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: event.eventBackgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      event.eventName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: event.eventTextColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ));
            },
            onPageChanged: (firstDate, lastDate) {
              /// Called when the page was changed
              /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
            },
          );
  }
}
