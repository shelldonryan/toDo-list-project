// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarController on CalendarControllerBase, Store {
  late final _$focusedDateAtom =
      Atom(name: 'CalendarControllerBase.focusedDate', context: context);

  @override
  DateTime get focusedDate {
    _$focusedDateAtom.reportRead();
    return super.focusedDate;
  }

  @override
  set focusedDate(DateTime value) {
    _$focusedDateAtom.reportWrite(value, super.focusedDate, () {
      super.focusedDate = value;
    });
  }

  late final _$rangeStartDateAtom =
      Atom(name: 'CalendarControllerBase.rangeStartDate', context: context);

  @override
  DateTime? get rangeStartDate {
    _$rangeStartDateAtom.reportRead();
    return super.rangeStartDate;
  }

  @override
  set rangeStartDate(DateTime? value) {
    _$rangeStartDateAtom.reportWrite(value, super.rangeStartDate, () {
      super.rangeStartDate = value;
    });
  }

  late final _$rangeEndDateAtom =
      Atom(name: 'CalendarControllerBase.rangeEndDate', context: context);

  @override
  DateTime? get rangeEndDate {
    _$rangeEndDateAtom.reportRead();
    return super.rangeEndDate;
  }

  @override
  set rangeEndDate(DateTime? value) {
    _$rangeEndDateAtom.reportWrite(value, super.rangeEndDate, () {
      super.rangeEndDate = value;
    });
  }

  late final _$calendarFormatAtom =
      Atom(name: 'CalendarControllerBase.calendarFormat', context: context);

  @override
  CalendarFormat get calendarFormat {
    _$calendarFormatAtom.reportRead();
    return super.calendarFormat;
  }

  @override
  set calendarFormat(CalendarFormat value) {
    _$calendarFormatAtom.reportWrite(value, super.calendarFormat, () {
      super.calendarFormat = value;
    });
  }

  late final _$CalendarControllerBaseActionController =
      ActionController(name: 'CalendarControllerBase', context: context);

  @override
  void onSelectedDay(DateTime focusedDay) {
    final _$actionInfo = _$CalendarControllerBaseActionController.startAction(
        name: 'CalendarControllerBase.onSelectedDay');
    try {
      return super.onSelectedDay(focusedDay);
    } finally {
      _$CalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onRangeSelected(
      DateTime? startDay, DateTime? endDay, DateTime? focusedDay) {
    final _$actionInfo = _$CalendarControllerBaseActionController.startAction(
        name: 'CalendarControllerBase.onRangeSelected');
    try {
      return super.onRangeSelected(startDay, endDay, focusedDay);
    } finally {
      _$CalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$CalendarControllerBaseActionController.startAction(
        name: 'CalendarControllerBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$CalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
focusedDate: ${focusedDate},
rangeStartDate: ${rangeStartDate},
rangeEndDate: ${rangeEndDate},
calendarFormat: ${calendarFormat}
    ''';
  }
}
