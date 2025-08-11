import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.lightBg,
      primaryColor: AppColors.lightBg,
      primaryColorDark: AppColors.black,
      primaryColorLight: AppColors.lightBg,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: AppColors.purple, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.purple, fontSize: 18),
        bodyLarge: TextStyle(color: AppColors.purple, fontSize: 20),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: AppColors.black
        ),
        foregroundColor: AppColors.black,
        backgroundColor: AppColors.lightBg,
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: AppColors.black,),
  ));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.purple,
      primaryColorDark: AppColors.lightBg,
      primaryColorLight: AppColors.darkBg,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: AppColors.offWhite, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.offWhite, fontSize: 18),
        bodyLarge: TextStyle(color: AppColors.offWhite, fontSize: 20),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            color: AppColors.purple
        ),
        foregroundColor: AppColors.purple,
        backgroundColor: AppColors.darkBg,
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: AppColors.purple,),
      ));
}
