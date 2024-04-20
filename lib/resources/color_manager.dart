import 'package:flutter/material.dart';

class ColorManager {
  static Color black900 = fromHex('#000000');

  static Color purple = fromHex("#7772e2");

  static Color blue = Colors.blue;

  static Color green = Colors.green;

  static Color blueGreen = const Color.fromARGB(255, 2, 255, 179);

  static Color cyan = Colors.cyan;

  static Color grey = Colors.grey;

  static Color red = Colors.red;

  static Color teal = Colors.teal;

  static Color blueCrayola = fromHex("#1f64f8");

  static Color cornFlowerBlue = fromHex("#6597f1");

  static Color catalinaBlue = fromHex("#042b80");

  static Color lightSlateGrey = fromHex("#7b839e");

  static Color lightSteelBlue = fromHex("#b3c4d7");

  static Color quartz = fromHex("#4c4454");

  static Color lightGrey = const Color.fromARGB(150, 94, 94, 94);

  static Color transparent = Colors.transparent;

  static Color whiteA700 = fromHex('#ffffff');

  static Color balck255 = fromHex('#1d1e22');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
