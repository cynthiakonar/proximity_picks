import 'dart:math';
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

double calculateDistanceInMeter(lat1, lon1, lat2, lon2) {
  print(lat1);
  print(lon1);
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  print(12742 * asin(sqrt(a)) * 1609.344);
  return 12742 * asin(sqrt(a)) * 1609.344;
}

findMatchingLists<T>(List lists, List targetList) {
  for (int i = 0; i < lists.length; i++) {
    for (int j = 0; i < targetList.length; i++) {
      if (lists[i] == targetList[j]) {
        return lists[i];
      }
    }
  }
  return "";
}
