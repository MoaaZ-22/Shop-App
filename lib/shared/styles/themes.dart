import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

ThemeData darkTheme =  ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedIconTheme: IconThemeData(color:defaultColor,size: 25),
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.1),
    unselectedLabelStyle: const TextStyle(
        fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.1),

  ),
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.lightGreen
      )
  ),
);