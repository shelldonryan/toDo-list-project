import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'calendar_controller.g.dart';

class CalendarController = CalendarControllerBase with _$CalendarController;

abstract class CalendarControllerBase with Store {

  @observable
  DateTime focusedDate = DateTime.now();

  @observable
  DateTime? rangeStartDate;

  @observable
  DateTime? rangeEndDate;

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
}