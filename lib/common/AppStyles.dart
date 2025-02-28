import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'AppColors.dart';

class AppStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  GroupButtonOptions gbo(BuildContext context) {
    return GroupButtonOptions(
      buttonWidth: MediaQuery.of(context).size.width * 0.9,
      selectedColor: AppColors.primaryColor,
      unselectedColor: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(100),
    );
  }
}
