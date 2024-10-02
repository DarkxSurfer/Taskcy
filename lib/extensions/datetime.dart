import 'package:jiffy/jiffy.dart';

extension FormatDateTime on DateTime {
  String get dateTime => Jiffy.parseFromDateTime(this).format(pattern: 'MMMMd');
  String get dateTimeCalendar =>
      Jiffy.parseFromDateTime(this).format(pattern: 'yMMMd');
}

extension DayOfWeek on DateTime {
  String get dayOfWeek => Jiffy.parseFromDateTime(this).format(pattern: 'EEEE');
}

extension DateTimeComparison on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
