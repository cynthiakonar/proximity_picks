import 'package:flutter/material.dart';

showMessage(String message, BuildContext context) {
  return ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueGrey,
      elevation: 8,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    ));
}
