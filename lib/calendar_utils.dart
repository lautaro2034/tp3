import 'package:flutter/material.dart';

class CalendarUtils {
  static List<DateTimeRange> generatePauseSlots(DateTime now) {
    return [
      DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 12, 0),
        end: DateTime(now.year, now.month, now.day, 13, 0),
      )
    ];
  }
}
