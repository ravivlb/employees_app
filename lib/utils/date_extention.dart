
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String convertAppFromatDate() {
    return DateFormat('dd MMM, yyyy').format(this);
  }

  String convertAppTextFieldFromatDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  DateTime next(int day) {
    int duration = day-weekday;
    return add(
      Duration(
        days: duration == 0 ? 7 : (duration) % DateTime.daysPerWeek,
      ),
    );
  }

  DateTime nextMonday() {
    return next(DateTime.monday);
  }

  DateTime nextTuesday() {
    return next(DateTime.tuesday);
  }

  DateTime nextWeekDay() {
    return DateTime(year, month, day+7);
  }

}