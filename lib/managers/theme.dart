import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playbucks/utils/constants.dart';

class PlaybucksTheme
{
  static const Map<int, Color> swatchColors = {
    50: Color.fromRGBO(217, 74, 74, .1),
    100: Color.fromRGBO(217, 74, 74, .2),
    200: Color.fromRGBO(217, 74, 74, .3),
    300: Color.fromRGBO(217, 74, 74, .4),
    400: Color.fromRGBO(217, 74, 74, .5),
    500: Color.fromRGBO(217, 74, 74, .6),
    600: Color.fromRGBO(217, 74, 74, .7),
    700: Color.fromRGBO(217, 74, 74, .8),
    800: Color.fromRGBO(217, 74, 74, .9),
    900: Color.fromRGBO(217, 74, 74, 1),
  };

  static const MaterialColor materialColor = MaterialColor(0xFFD94A4A, swatchColors);

  static TextTheme lightTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontFamily: "Nunito",
      fontSize: 14.sp,
      color: primary,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: "Nunito",
      fontSize: 12.sp,
      color: primary,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Nunito",
      fontSize: 16.sp,
      color: primary,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
        fontFamily: "Nunito",
        fontSize: 28.sp,
        color: primary,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 20.sp,
        color: primary,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
        fontFamily: "Nunito",
        fontSize: 24.sp,
        color: primary,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 12.sp,
        color: primary,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontFamily: "Nunito",
      fontSize: 14.sp,
      color: primary,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontFamily: "Nunito",
      fontSize: 16.sp,
      color: primary,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontFamily: "Nunito",
      fontSize: 12.sp,
      color: midPrimary,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: TextStyle(
      fontFamily: "Nunito",
      fontSize: 14.sp,
      color: midPrimary,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: TextStyle(
      fontFamily: "Nunito",
      fontSize: 16.sp,
      color: midPrimary,
      fontWeight: FontWeight.w300,
    )
  );

  static TextTheme darkTextTheme = TextTheme(
      bodyMedium: TextStyle(
        fontFamily: "Nunito",
        fontSize: 14.sp,
        color: theme,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 12.sp,
        color: theme,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Nunito",
        fontSize: 16.sp,
        color: theme,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontFamily: "Nunito",
        fontSize: 28.sp,
        color: theme,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 20.sp,
        color: theme,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Nunito",
        fontSize: 24.sp,
        color: theme,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 12.sp,
        color: theme,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontFamily: "Nunito",
        fontSize: 14.sp,
        color: theme,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: "Nunito",
        fontSize: 18.sp,
        color: theme,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: "Nunito",
        fontSize: 12.sp,
        color: neutral3,
        fontWeight: FontWeight.w300,
      ),
      labelMedium: TextStyle(
        fontFamily: "Nunito",
        fontSize: 14.sp,
        color: neutral3,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: TextStyle(
        fontFamily: "Nunito",
        fontSize: 16.sp,
        color: neutral3,
        fontWeight: FontWeight.w300,
      )
  );

  static ThemeData light() => ThemeData(
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    primaryColor: theme,
    primarySwatch: materialColor,
    scaffoldBackgroundColor: theme,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: theme
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: primary,
      backgroundColor: theme
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 1.0,
      foregroundColor: theme,
      backgroundColor: appRed,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: appRed,
      backgroundColor: theme,
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: primary
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: theme,
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: appRed,
      labelStyle: lightTextTheme.bodyMedium,
      unselectedLabelStyle: lightTextTheme.labelMedium,
    )

  );

  static ThemeData dark() => ThemeData(
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
      primarySwatch: materialColor,
      appBarTheme: const AppBarTheme(
          foregroundColor: theme,
          backgroundColor: primary
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: midPrimary
      ),
      primaryColor: primary,
      scaffoldBackgroundColor: primary,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: theme
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 1.0,
        foregroundColor: theme,
        backgroundColor: appRed,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: appRed,
        backgroundColor: primary,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: primary,
      ),
      tabBarTheme: TabBarTheme(
          indicatorColor: appRed,
          labelStyle: darkTextTheme.bodyMedium,
        unselectedLabelStyle: darkTextTheme.labelMedium,
      )
  );
}