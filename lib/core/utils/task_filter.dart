import 'dart:core';
import '../../features/task/models/task.dart';

class TaskFilterController {
  List<Task> filterTasks(List<Task> allTasks, String filter,
      {DateTime? startRangeDate, DateTime? endRangeDate}) {
    switch (filter) {
      case "today":
        return _filterTodayTasks(allTasks);
      case "tomorrow":
        return _filterTomorrowTasks(allTasks);
      case "week":
        return _filterWeekTasks(allTasks);
      case "month":
        return _filterMonthTasks(allTasks);
      case "custom":
        return _filterCustomTasks(
            allTasks, startRangeDate!, endRangeDate ?? startRangeDate);
      case "all":
      default:
        return allTasks;
    }
  }

  List<Task> _filterTodayTasks(List<Task> tasksUser) {
    DateTime today = DateTime.now();
    DateTime startDate = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endDate = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final taskToday = tasksUser.where((task) =>
        task.createdAt.isAfter(startDate) && task.createdAt.isBefore(endDate));

    return taskToday.toList();
  }

  List<Task> _filterTomorrowTasks(List<Task> tasksUser) {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    DateTime startDate =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0, 0);
    DateTime endDate =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59, 59);

    final taskTomorrow = tasksUser.where((task) =>
        task.createdAt.isAfter(startDate) && task.createdAt.isBefore(endDate));

    return taskTomorrow.toList();
  }

  List<Task> _filterWeekTasks(List<Task> tasksUser) {
    DateTime today = DateTime.now();
    DateTime startFilter =
        DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter =
        today.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    final taskWeek = tasksUser.where((task) =>
        task.createdAt.isAfter(startFilter) &&
        task.createdAt.isBefore(endFilter.add(const Duration(seconds: 1))));

    return taskWeek.toList();
  }

  List<Task> _filterMonthTasks(List<Task> tasksUser) {
    DateTime today = DateTime.now();
    DateTime startFilter = DateTime(today.year, today.month, 1);
    DateTime endFilter = DateTime(today.year, today.month + 1, 1)
        .subtract(const Duration(seconds: 1));

    final taskMonth = tasksUser.where((task) =>
        task.createdAt.isAfter(startFilter) &&
        task.createdAt
            .isBefore(endFilter.subtract(const Duration(seconds: 1))));

    return taskMonth.toList();
  }

  List<Task> _filterCustomTasks(
      List<Task> tasksUser, DateTime startRangeDate, DateTime endRangeDate) {
    DateTime startFilter = startRangeDate;
    DateTime endFilter =
        endRangeDate.add(const Duration(hours: 23, minutes: 59, seconds: 59));

    final taskCustom = tasksUser.where((task) =>
        task.createdAt.isAfter(startFilter) &&
        task.createdAt.isBefore(endFilter));

    return taskCustom.toList();
  }
}
