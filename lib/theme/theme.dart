import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: Colors.grey.shade100,
        secondary: Colors.grey.shade400,
        background: Color(0xFF000066),
        onBackground: Colors.grey.shade400,
        onPrimaryContainer: Colors.grey.shade400,
        outline: Colors.grey.shade900,
        onPrimary: Colors.black, //Main Text Color
        onSecondary: Colors.grey.shade800, // Secondary Text Color
        tertiary: Color(0xFF4B7BF5),
        onTertiary: Colors.grey.shade500,
        onSurface: Colors.grey.shade200,
        onSurfaceVariant: Colors.grey.shade600,
        onInverseSurface: Colors.grey.shade300, //button shadow 1
        onError: Colors.grey.shade400, //button shadow 1
        onErrorContainer: Colors.grey.shade900 //button icon color
        ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
        primary: Color.fromARGB(255, 29, 36, 63),
        secondary: Color.fromARGB(255, 24, 13, 30),
        background: Color(0xFF3FE8E6),
        onBackground: Color(0xFF203248),
        onPrimaryContainer: Color(0xFF203248),
        outline: Colors.grey.shade100,
        onPrimary: Colors.white, // main text color )
        onSecondary: Colors.grey.shade200, // secondary text color
        tertiary: Color(0xFF79A9F5),
        onTertiary: Color.fromARGB(255, 53, 29, 65),
        onSurface: Color.fromARGB(217, 38, 35, 113),
        onSurfaceVariant: Color.fromARGB(255, 53, 29, 65),
        onInverseSurface: Colors.grey.shade300, //button shadow 1
        onError: Colors.grey.shade400, //button shadow 1
        onErrorContainer: Colors.grey.shade700 //button icon color
        ));
