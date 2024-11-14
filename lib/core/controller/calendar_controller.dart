import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_controller.g.dart';

class CalendarController = CalendarControllerBase with _$CalendarController;

abstract class CalendarControllerBase with Store {
  DateTime firstDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime endDate = DateTime.now().add(const Duration(days: 365));

  @observable
  DateTime focusedDate = DateTime.now();

  @observable
  DateTime? rangeStartDate;

  @observable
  DateTime? rangeEndDate;

  @observable
  CalendarFormat calendarFormat = CalendarFormat.month;

  @action
  void onSelectedDay(DateTime focusedDay){
    if (focusedDate == focusedDay) {
      focusedDate = DateTime.now();
    } else {
      focusedDate = focusedDay;
    }
  }

  @action
  void onRangeSelected(DateTime? startDay, DateTime? endDay, DateTime? focusedDay) {
    rangeStartDate = startDay;
    rangeEndDate = endDay;
    focusedDay = focusedDay;
  }

  @action
  void dispose() {
    focusedDate = DateTime.now();
    rangeStartDate = null;
    rangeEndDate = null;
  }
}