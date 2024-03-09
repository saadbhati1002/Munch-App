import 'dart:async';
import 'package:flutter/material.dart';

class ViewUtils {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String enumToString(Object o) => o.toString().split('.').last;

  static checkInternetConnectionDialog() {}

  static Future<bool> isConnected() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   return true;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   return true;
    // }
    return true;
  }
}
