import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list_project/core/controller/calendar_controller.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';

Widget CalendarWidget({
  required bool isRange,
  required CalendarController controller,
}) {
  Color color = MyColors.greenForest;

  return TableCalendar(
    focusedDay: controller.focusedDate,
    firstDay: controller.firstDate,
    lastDay: controller.endDate,
    calendarFormat: controller.calendarFormat,
    rangeStartDay: isRange ? controller.rangeStartDate : null,
    rangeEndDay: isRange ? controller.rangeEndDate : null,
    rangeSelectionMode:
        isRange ? RangeSelectionMode.toggledOn : RangeSelectionMode.toggledOff,
    selectedDayPredicate: (day) => isSameDay(day, controller.focusedDate),
    onFormatChanged: (CalendarFormat cf) {
      controller.calendarFormat = cf;
    },
    onDaySelected: (selectedDay, focusedDay) {
      controller.onSelectedDay(focusedDay);
    },
    onRangeSelected: (startDay, endDay, focusedDay) {
      controller.rangeStartDate = startDay;
      controller.rangeEndDate = endDay;
      controller.focusedDate = focusedDay;
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
      todayDecoration:
          BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.6)),
      selectedTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: isSameDay(DateTime.now(), controller.focusedDate)
            ? FontWeight.normal
            : FontWeight.normal,
        fontSize: isSameDay(DateTime.now(), controller.focusedDate) ? 16 : 14,
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
      rangeHighlightColor: color.withOpacity(0.15),
    ),
  );
}
