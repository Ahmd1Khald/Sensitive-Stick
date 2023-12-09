import 'package:flutter/material.dart';

class AppFunctions {
  static void pushTo({required context, required Widget screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
