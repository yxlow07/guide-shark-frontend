import 'package:flutter/material.dart';
import '../AppStyles.dart';

class Question {
  static Widget build(String title, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: AppStyles.title, textAlign: TextAlign.center),
        SizedBox(height: 20),
        ...children,
      ],
    );
  }
}
