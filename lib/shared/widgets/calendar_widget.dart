import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime firstDate;
  final DateTime endDate;
  DateTime? focusedDate;
  DateTime? selectedDate;
  DateTime? rangeFirstDate;
  DateTime? rangeEndDate;
  bool isRange;

  CalendarFormat calendarFormat = CalendarFormat.month;
  Color color = MyColors.greenForest;

  CalendarWidget({
    super.key,
    required this.firstDate,
    required this.endDate,
    required this.focusedDate,
    required this.selectedDate,
    required this.rangeFirstDate,
    required this.rangeEndDate,
    required this.isRange,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDate ?? DateTime.now(),
      firstDay: firstDate,
      lastDay: endDate,
      calendarFormat: calendarFormat,
      rangeStartDay: isRange ? rangeFirstDate : null,
      rangeEndDay: isRange ? rangeEndDate : null,
      rangeSelectionMode: isRange
          ? RangeSelectionMode.toggledOn
          : RangeSelectionMode.toggledOff,
      selectedDayPredicate: (day) => isSameDay(day, focusedDate),
      onFormatChanged: (CalendarFormat cf) {
        calendarFormat = cf;
      },
      onDaySelected: (selectedDay, focusedDay) {
        focusedDate = focusedDay;
      },
      onRangeSelected: (startDay, endDay, focusedDay) {
        rangeFirstDate = startDay;
        rangeEndDate = endDay;
        focusedDate = focusedDay;
      },
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
            shape: BoxShape.circle, color: color.withOpacity(0.2)),
        selectedTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: isSameDay(DateTime.now(), focusedDate)
              ? FontWeight.normal
              : FontWeight.normal,
          fontSize: isSameDay(DateTime.now(), focusedDate) ? 16 : 14,
        ),
        selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: color),
        rangeStartDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        rangeEndDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        rangeHighlightColor: color.withOpacity(0.8),
      ),
    );
  }
}
