import 'package:flutter/material.dart';
import 'package:guide_shark/common/AppColors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor, primary: AppColors.primaryColor),
  );

  static ThemeData darkTheme = ThemeData(primaryColor: AppColors.primaryColor, brightness: Brightness.dark);
}
