import 'package:flutter/material.dart';

showErrorSnackBar({required BuildContext context, required String error}) {
  SnackBar snackBar = SnackBar(
    content: Text(error),
    showCloseIcon: true,
    backgroundColor: Colors.amber[500],
    closeIconColor: Colors.white,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
