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

showSnackBar({required BuildContext context, required String message}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    showCloseIcon: true,
    backgroundColor: Colors.black54,
    closeIconColor: Colors.white,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
