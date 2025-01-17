import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastGetter {
  static getToast(String mes) {
    return Fluttertoast.showToast(
        msg: mes,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
