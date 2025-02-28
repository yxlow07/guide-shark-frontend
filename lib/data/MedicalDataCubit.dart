import 'package:bloc/bloc.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:guide_shark/screens/Questions/Radiation.dart';
import 'package:guide_shark/screens/Questions/RadiationLocation.dart';
import '../common/widgets/BodyPartSelector.dart';
import '../screens/Questions/PainCharacter.dart';
import 'MedicalDataState.dart';
import 'MedicalData.dart';

class MedicalDataCubit extends Cubit<MedicalDataState> {
  MedicalDataCubit() : super(MedicalDataState(currentPageIndex: 0));

  void initQuestionPages(List<Widget> pages) {
    emit(state.copyWith(pages: List.from(pages)));
  }

  void nextPage() {
    emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
  }

  void previousPage() {
    if (state.currentPageIndex > 0) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex - 1));
    }
  }

  void updateBodyPartMAC(String bodyPart, BodyParts bodyParts) {
    emit(
      state.copyWith(
        formData: state.formData.copyWith(
          selectedBodyPartMAC: bodyPart,
          bodyPartsMAC: bodyParts,
        ),
      ),
    );
  }

  void updatePainType(String painCharacter) {
    emit(
      state.copyWith(
        formData: state.formData.copyWith(painCharacter: painCharacter),
      ),
    );
  }

  // Method to get the collected data (for submission later)
  MedicalData getFormData() {
    return state.formData;
  }

  void updateRadiation(String radiation) {
    emit(
      state.copyWith(formData: state.formData.copyWith(radiation: radiation)),
    );
  }

  void updateSelectedBodyPartR(String bodyPart, BodyParts bodyParts) {
    emit(
      state.copyWith(
        formData: state.formData.copyWith(
          selectedBodyPartR: bodyPart,
          bodyPartsR: bodyParts,
        ),
      ),
    );
  }

  void addRadiationLocationPage() {
    var radiationPage = RadiationLocation().radiationLocation(this);
    var questionPages = state.pages;
    int location = 3;
    questionPages.insert(location, radiationPage);
    emit(state.copyWith(pages: questionPages, currentPageIndex: location - 1));
    print(state.pages);
    print("Added radiation body selector, redirected to $location");
  }

  void removeRadiationLocationPage() {
    var questionPages = state.pages;
    int location = 2;
    questionPages.removeAt(3);
    emit(state.copyWith(pages: questionPages, currentPageIndex: location));

    print(state.pages);
    print("Removed radiation body selector, redirected to $location");
  }
}
