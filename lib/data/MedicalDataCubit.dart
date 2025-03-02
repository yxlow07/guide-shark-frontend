import 'package:bloc/bloc.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:guide_shark/screens/Questions/RadiationLocation.dart';
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
    emit(
      state.copyWith(
        pages: questionPages,
        currentPageIndex: location - 1,
        formData: state.formData.copyWith(addedRadiation: true),
      ),
    );
  }

  void removeRadiationLocationPage() {
    var questionPages = state.pages;
    int location = 2;
    if (state.formData.addedRadiation == true) {
      questionPages.removeAt(3);
    }
    emit(state.copyWith(pages: questionPages, currentPageIndex: location));
  }

  void addAssociatedSymptoms(String symptom) {
    List<String> associatedSymptoms = List.from(
      state.formData.associatedSymptoms ?? [],
    );
    if (!associatedSymptoms.contains(symptom)) {
      associatedSymptoms.add(symptom);
    }
    emit(
      state.copyWith(
        formData: state.formData.copyWith(
          associatedSymptoms: associatedSymptoms,
        ),
      ),
    );
  }

  void removeAssociatedSymptoms(String symptom) {
    List<String> associatedSymptoms = List.from(
      state.formData.associatedSymptoms ?? [],
    );
    associatedSymptoms.remove(symptom);
    emit(
      state.copyWith(
        formData: state.formData.copyWith(
          associatedSymptoms: associatedSymptoms,
        ),
      ),
    );
  }

  void clearAssociatedSymptoms() {
    emit(
      state.copyWith(formData: state.formData.copyWith(associatedSymptoms: [])),
    );
  }

  void updatePainTimingType(bool constantPain) {
    emit(
      state.copyWith(
        formData: state.formData.copyWith(constantPain: constantPain),
      ),
    );
  }

  void updateClockSelector(TimeOfDay time) {
    emit(state.copyWith(formData: state.formData.copyWith(time: time)));
  }

  void markClockSelectorShown() {
    emit(
      state.copyWith(
        formData: state.formData.copyWith(clockSelectorShown: true),
      ),
    );
  }
}
