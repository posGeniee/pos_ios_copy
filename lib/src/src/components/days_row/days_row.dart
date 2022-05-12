// import 'package:app_office_1/const.dart';

import 'package:dummy_app/helpers/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../cell_calendar.dart';
import '../../calendar_event.dart';
import '../../controllers/calendar_state_controller.dart';
import '../../controllers/cell_height_controller.dart';
import 'event_labels.dart';
import 'measure_size.dart';
import 'package:intl/intl.dart';

/// Show the row of [_DayCell] cells with events
class DaysRow extends StatelessWidget {
  const DaysRow({
    required this.visiblePageDate,
    required this.dates,
    required this.dateTextStyle,
    Key? key,
  }) : super(key: key);

  final List<DateTime> dates;
  final DateTime visiblePageDate;
  final TextStyle? dateTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: dates.map((date) {
          return _DayCell(
            date,
            visiblePageDate,
            dateTextStyle,
          );
        }).toList(),
      ),
    );
  }
}

/// Cell of calendar.
///
/// Its height is circulated by [MeasureSize] and notified by [CellHeightController]
/// Numbers to return accurate events in the cell.

class _DayCell extends StatelessWidget {
  _DayCell(this.date, this.visiblePageDate, this.dateTextStyle);

  final DateTime date;
  final DateTime visiblePageDate;
  final TextStyle? dateTextStyle;

  List<CalendarEvent> _eventsOnTheDay(
      DateTime date, List<CalendarEvent> events) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    return Selector<CalendarStateController, List<CalendarEvent>>(
        builder: (context, events, _) {
          _eventsOnTheDay(date, events);

          return Expanded(
            child: GestureDetector(
              onTap: () {
                Provider.of<CalendarStateController>(context, listen: false)
                    .onCellTapped(date);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: (_eventsOnTheDay(date, events).isNotEmpty)
                      ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment
                              .centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            colorwhite,
                            colorpink
                          ], // red to yellow
                          // repeats the gradient over the canvas
                        )
                      : const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment
                              .centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Colors.white,
                            Colors.white
                          ], // red to yellow
                          // repeats the gradient over the canvas
                        ),
                  border: Border(
                    top: BorderSide(color: colorblue, width: 1),
                    right: BorderSide(color: colorblue, width: 1),
                  ),
                ),
                child: MeasureSize(
                  onChange: (size) {
                    if (size == null) return;
                    Provider.of<CellHeightController>(context, listen: false)
                        .onChanged(size);
                  },
                  child: Stack(
                    children: [
                      if (_eventsOnTheDay(date, events).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            assetImage,
                            height: 10,
                          ),
                        ),
                      isToday
                          ? Align(
                              alignment: Alignment.center,
                              child: _TodayLabel(
                                date: date,
                                dateTextStyle: dateTextStyle,
                              ),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: _DayLabel(
                                date: date,
                                visiblePageDate: visiblePageDate,
                                dateTextStyle: dateTextStyle,
                              ),
                            ),
                      // EventLabels(date),
                      if (_eventsOnTheDay(date, events).isNotEmpty)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            _eventsOnTheDay(date, events)[0].eventName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              // fontFamily: heeboFontFamily,
                              fontSize: 8,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        selector: (context, controller) => controller.events);
  }
}

class _TodayLabel extends StatelessWidget {
  const _TodayLabel({
    Key? key,
    required this.date,
    required this.dateTextStyle,
  }) : super(key: key);

  final DateTime date;
  final TextStyle? dateTextStyle;

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<TodayUIConfig>(context, listen: false);
    final caption = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontWeight: FontWeight.w500);
    final textStyle = caption.merge(dateTextStyle);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: config.todayMarkColor,
      ),
      child: Center(
        child: Text(
          date.day.toString(),
          textAlign: TextAlign.center,
          style: textStyle.copyWith(
            color: config.todayTextColor,
          ),
        ),
      ),
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel({
    Key? key,
    required this.date,
    required this.visiblePageDate,
    required this.dateTextStyle,
  }) : super(key: key);

  final DateTime date;
  final DateTime visiblePageDate;
  final TextStyle? dateTextStyle;

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth = visiblePageDate.month == date.month;
    var data = DateFormat('EEEE').format(date);
    final caption = Theme.of(context).textTheme.caption!.copyWith(
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface);
    final textStyle = caption.merge(dateTextStyle);

    return Container(
      margin: EdgeInsets.symmetric(vertical: dayLabelVerticalMargin.toDouble()),
      height: dayLabelContentHeight.toDouble(),
      child: Text(
        date.day.toString(),
        textAlign: TextAlign.center,
        style: textStyle.copyWith(
          color: (data.toString() == 'Sunday' || data.toString() == 'Saturday')
              ? isCurrentMonth
                  ? colorpink
                  : colorpink.withOpacity(0.4)
              : isCurrentMonth
                  ? textStyle.color
                  : textStyle.color!.withOpacity(0.4),
        ),
      ),
    );
  }
}
