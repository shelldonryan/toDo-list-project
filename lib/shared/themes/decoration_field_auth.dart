import 'package:flutter/material.dart';
import 'my_colors.dart';

InputDecoration getAuthInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.white10,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(),
      borderSide: BorderSide(color: Colors.black12, width: 1),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(),
      borderSide: BorderSide(color: MyColors.greenForest, width: 1.5),
    ),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: Colors.amber, width: 1)
    ),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(),
        borderSide: BorderSide(color: Colors.amber, width: 1.5)
    ),
  );
}