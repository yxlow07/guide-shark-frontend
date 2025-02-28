import 'package:flutter/material.dart';
import 'MedicalData.dart';

class MedicalDataState {
  final int currentPageIndex;
  final MedicalData formData;
  final List<Widget> pages;

  MedicalDataState({
    this.currentPageIndex = 0,
    MedicalData? formData,
    List<Widget>? pages,
  }) : formData = formData ?? MedicalData(),
       pages = pages ?? [];

  MedicalDataState copyWith({
    int? currentPageIndex,
    MedicalData? formData,
    List<Widget>? pages,
  }) {
    return MedicalDataState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      formData: formData ?? this.formData,
      pages: pages ?? this.pages,
    );
  }
}
