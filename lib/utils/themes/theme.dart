
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';


ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: MyColors.lightThemeColor,
    scaffoldBackgroundColor:MyColors.lightScaffoldColor,
    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0, color: MyColors.lightThemeColor),
    iconTheme: const IconThemeData(color: MyColors.lightLightTextColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: MyColors.lightTextColor),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => MyColors.lightContainerColor),
      overlayColor:  MaterialStateColor.resolveWith((states) => MyColors.lightTextColor),
    ),

    colorScheme: const ColorScheme.light(
      primary: MyColors.lightTextColor ,
      onPrimary: MyColors.lightButtonTextColor,
      secondary: MyColors.lightLightTextColor,
      primaryContainer: MyColors.lightContainerColor,
      secondaryContainer:MyColors.black,
      error: MyColors.red
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1.h,
      backgroundColor: MyColors.lightContainerColor,
      selectedItemColor: MyColors.lightTitleColor,
      unselectedItemColor: MyColors.lightLightTextColor,
      selectedIconTheme: const IconThemeData(color: MyColors.lightTitleColor),
      showUnselectedLabels: true,
    ),
  );
}
//
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: MyColors.darkThemeColor,
    scaffoldBackgroundColor: MyColors.darkThemeColor,
    appBarTheme:const AppBarTheme(centerTitle: false, elevation: 0, color: MyColors.darkThemeColor),
    iconTheme: const IconThemeData(color: MyColors.darkLightTextColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: MyColors.darkTextColor),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: MyColors.darkTextColor ,
      onPrimary: MyColors.darkButtonTextColor,
      secondary: MyColors.darkLightTextColor,
      primaryContainer: MyColors.darkContainerColor,
      secondaryContainer:MyColors.white,
      error:MyColors.red,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1.h,
      backgroundColor: MyColors.darkContainerColor,
      selectedItemColor: MyColors.darkTitleColor,
      unselectedItemColor: MyColors.darkContainerColor,
      selectedIconTheme: const IconThemeData(color: MyColors.darkTitleColor),
      showUnselectedLabels: true,
    ),
  );
}

