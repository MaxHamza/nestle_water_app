import 'package:flutter/material.dart';
class SignUpSnack{
  final String response;
  SignUpSnack({required this.response});
    SnackBar get snackBar {
    return SnackBar(
      content: Text(response),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'نعم',
        onPressed: () {},
      ),);
  }
}