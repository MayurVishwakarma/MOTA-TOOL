import 'package:flutter/material.dart';

getOutlineInputBorder({
  Color? color = Colors.black,
}) {
  return OutlineInputBorder(
      borderSide:const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(5));
}
