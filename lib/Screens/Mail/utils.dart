import 'package:flutter/material.dart';

class Utils {
  static showCustomSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
