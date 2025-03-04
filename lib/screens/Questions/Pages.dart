import 'package:flutter/material.dart';
import 'package:guide_shark/data/MedicalDataState.dart';
import 'package:guide_shark/data/MedicalDataCubit.dart';

class Pages {
  static Widget buildPages(
    BuildContext context,
    MedicalDataState state,
    PageController _pageController,
    MedicalDataCubit cubit,
  ) {
    return PageView(
      controller: _pageController,
      children:
          state.pages.map((page) {
            return page;
          }).toList(),
      onPageChanged: (index) => cubit.emit(cubit.state.copyWith(currentPageIndex: index)),
    );
  }
}
