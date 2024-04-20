import 'package:flutter/material.dart';
import 'package:motatool/resources/color_manager.dart';

class ThemeManager {
  ThemeData lightThemeData = ThemeData(
    primaryColor: ColorManager.balck255,
    primaryColorLight: ColorManager.whiteA700,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    dialogTheme: const DialogTheme(backgroundColor: Colors.white),
    scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: ColorManager.blueCrayola,
            backgroundColor: const Color.fromARGB(255, 253, 253, 253),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ))),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
      toolbarHeight: 50,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: Colors.deepOrange,
        iconColor: Colors.deepOrange,
        collapsedShape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(10),
            // side: BorderSide(color: Colors.black)
            )),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
      bodyLarge: TextStyle(color: Colors.black),
      bodySmall: TextStyle(
        color: Colors.black,
      ),
    ),
    hintColor: Colors.black,
  );
}
