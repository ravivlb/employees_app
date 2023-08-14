import 'package:employees_app/components/action_bar.dart';
import 'package:employees_app/components/app_action_button.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:employees_app/utils/date_extention.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final DateType? type;
  final DateTime? startDate;
  final Function(DateTime?) onSaveDate;
  const CalendarView(
      {super.key,
      this.type = DateType.start,
      this.startDate,
      required this.onSaveDate});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  
  Color backgroundColor = Colors.black.withOpacity(0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Calender(
        type: widget.type,
        startDate: widget.startDate,
        onSaveDate: (p0) {
          widget.onSaveDate(p0);
        },
      ),
      backgroundColor: backgroundColor,
    );
  }
}

class Calender extends StatefulWidget {
  /// Date type start and end date
  final DateType? type;

  /// Start date whcih helps to validate relieving date of start date
  final DateTime? startDate;

  /// callback which helps to pass the date to parent
  final Function(DateTime?) onSaveDate;

  const Calender(
      {super.key,
      this.type = DateType.start,
      this.startDate,
      required this.onSaveDate});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  /// Calendar format
  CalendarFormat _calendarFormat = CalendarFormat.month;

  /// Focus date
  DateTime _focusedDay = DateTime.now();

  /// Selected date
  DateTime? _selectedDay;

  /// Slected customized button
  int selectedButtonIndex = 0;

  bool isLoaded =  false;


  @override
  Widget build(BuildContext context) {
    if(!isLoaded){
        isLoaded = true;
        _focusedDay = widget.startDate ?? DateTime.now();
    }
    double veticalPadding = ((MediaQuery.of(context).size.height-470)/2)-10;
    return Padding(
      padding:
          EdgeInsets.only(left: 16, right: 16, bottom: veticalPadding , top: veticalPadding),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              _getActionButtons(),
              Expanded(flex: 5, child: _getCalendarView()),
              Expanded(flex: 0, child: getActionBar()),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 5,
        physics: const NeverScrollableScrollPhysics(),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: getActions(),
      ),
    );
  }

  /// Returns customized button actions
  List<AppActionButton> getActions() {
    if (widget.type == DateType.start) {
      return [
        AppActionButton(
            title: kTodayButtonTitle,
            isSelected: selectedButtonIndex == 0,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 0;
                _selectedDay = DateTime.now();
              });
            }),
        AppActionButton(
            title: kNextMondayTitle,
            isSelected: selectedButtonIndex == 1,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 1;
                _selectedDay = DateTime.now().nextMonday();
              });
            }),
        AppActionButton(
            title: kNextTuesdayTitle,
            isSelected: selectedButtonIndex == 2,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 2;
                _selectedDay = DateTime.now().nextTuesday();
              });
            }),
        AppActionButton(
            title: kAfter1WeekTitle,
            isSelected: selectedButtonIndex == 3,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 3;
                _selectedDay = DateTime.now().nextWeekDay();
              });
            })
      ];
    } else {
      return [
        AppActionButton(
            title: kNoDatePlaceholder,
            isSelected: selectedButtonIndex == 0,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 0;
                _selectedDay = null;
              });
            }),
        AppActionButton(
            title: kTodayButtonTitle,
            isSelected: selectedButtonIndex == 1,
            onPressed: () {
              setState(() {
                selectedButtonIndex = 1;
                _selectedDay = DateTime.now();
              });
            })
      ];
    }
  }

  Widget _getCalendarView() {
    return TableCalendar(
      firstDay: widget.startDate ?? kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      rowHeight: 40,
      calendarStyle: getCalendarStyle(),
      headerStyle: getCalendarHeaderStyle(),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }

  /// return calendar style
  CalendarStyle getCalendarStyle() {
    return CalendarStyle(
        selectedDecoration: getSelectedDecoration(),
        todayDecoration: getTodayDecoration(),
        todayTextStyle: getCalendarTextStyle());
  }

  /// returns calendar header style
  HeaderStyle getCalendarHeaderStyle() =>
      const HeaderStyle(titleCentered: true, formatButtonVisible: false, titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500));

  /// Returns get calendar text style
  TextStyle getCalendarTextStyle() => const TextStyle(color: kPrimaryColor);

  /// return today box decoration
  BoxDecoration getTodayDecoration() {
    return BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: kPrimaryColor));
  }

  /// return selected day box decoration
  BoxDecoration getSelectedDecoration() =>
      const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor);

  /// Returns action bar
  Widget getActionBar() {
    return ActionBar(
        showCalendar: true,
        date: (_selectedDay == null
            ? kNoDatePlaceholder
            : _selectedDay!.convertAppTextFieldFromatDate()),
        onSave: () {
          if (widget.type == DateType.start && _selectedDay == null) {
            _selectedDay = DateTime.now();
          }
          widget.onSaveDate(_selectedDay);
          Navigator.of(context).pop();
        },
        onCancel: () {
          Navigator.of(context).pop();
        });
  }
}

/*

*/

enum DateType { start, end }
