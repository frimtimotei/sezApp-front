import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/calssEvents.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key key}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime date3 = DateTime.now();
  HashMap<DateTime, List<String>> events;


  CalendarFormat formatDate = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });


    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = new DateTime.now();
    DateTime _lastDate = new DateTime(now.year + 5);
    DateTime _firstDate = new DateTime(now.year - 10);
    return Column(
      children: [
        Container(

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, 0.1),
                    blurRadius: 50.0,
                    offset: Offset(0, 15))
              ]),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: size.width*0.06,vertical: 10),
          child: TableCalendar(

            focusedDay: _focusedDay,
            firstDay: _firstDate,
            lastDay: _lastDate,
            calendarFormat: formatDate,
            onFormatChanged: (format) {
              setState(() {
                formatDate = format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekVisible: true,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected:_onDaySelected,
            eventLoader: _getEventsForDay,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },


            ////Style
            calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.2),
                        blurRadius: 20.0,
                        offset: Offset(0, 5))
                  ],
                ),
                todayDecoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.2),
                        blurRadius: 20.0,
                        offset: Offset(0, 5))
                  ],
                )),
            headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.1),
                        blurRadius: 20.0,
                        offset: Offset(0, 10))
                  ],
                ),
                formatButtonTextStyle: TextStyle(
                  color: kLightColor,
                )),
          ),
        ),

      ],
    );

  }


}
