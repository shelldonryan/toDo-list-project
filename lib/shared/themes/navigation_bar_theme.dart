import 'package:flutter/material.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';

NavigationBarThemeData GetNavigationBarTheme() => const NavigationBarThemeData(
    backgroundColor: MyColors.greenForest,
    height: 75,
    iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white, size: 30)),
    labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
  );