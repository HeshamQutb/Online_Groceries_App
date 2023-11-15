import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.white
  ),
    // primarySwatch: customMaterialColor,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15.0,fontFamily: 'Jannah'),
        iconTheme: const IconThemeData(color: Colors.white, size: 18.0)),
    cardTheme: CardTheme(
        color: HexColor('333739')
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.white,
        elevation: 50,
        backgroundColor: HexColor('333739')
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
     backgroundColor: HexColor('333739'),
      foregroundColor: Colors.white
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        height: 1.3
        ),
      bodyMedium: TextStyle(
          color: Colors.white,
        height: 1.3
        ),
      bodySmall: TextStyle(
          color: Colors.grey,
        height: 1.3
        ),
    ),
    fontFamily: 'Jannah'
);


// ##################################################


ThemeData lightTheme = ThemeData(
  // primarySwatch: customMaterialColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0,fontFamily: 'Jannah'),
      iconTheme: IconThemeData(color: Colors.black, size: 18.0)),
  cardTheme: const CardTheme(
    color: Colors.white
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 50,
      backgroundColor: Colors.white
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    foregroundColor: Colors.grey
  ),
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
    titleMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.3
    ),
    bodyMedium: TextStyle(
        color: Colors.black,
        height: 1.3
    ),
  ),
  fontFamily: 'Jannah',
);
