import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Color.fromARGB(255, 31, 31, 31),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  // scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black,
  ),
  // primarySwatch: Colors.yellow,
);
