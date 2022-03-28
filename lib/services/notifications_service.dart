import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messegerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ));
    messegerKey.currentState!.showSnackBar(snackBar);
  }
}
