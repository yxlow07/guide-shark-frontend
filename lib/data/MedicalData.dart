import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';

class MedicalData {
  // Main Area of Concern MAC
  BodyParts bodyPartsMAC;
  String? selectedBodyPartMAC;
  String? painCharacter;
  // Radiation R
  bool? addedRadiation;
  String? radiation;
  BodyParts bodyPartsR;
  String? selectedBodyPartR;
  List<String>? associatedSymptoms;
  bool? constantPain;
  TimeOfDay time;
  bool clockSelectorShown;

  // TODO: Add get isComplete method

  MedicalData({
    BodyParts? bodyPartsMAC,
    this.selectedBodyPartMAC,
    this.painCharacter,
    this.addedRadiation,
    this.radiation,
    BodyParts? bodyPartsR,
    this.selectedBodyPartR,
    this.associatedSymptoms,
    this.constantPain,
    TimeOfDay? time,
    this.clockSelectorShown = false,
  }) : bodyPartsMAC = bodyPartsMAC ?? BodyParts(),
       bodyPartsR = bodyPartsR ?? BodyParts(),
       time = time ?? TimeOfDay(hour: 0, minute: 0);

  MedicalData copyWith({
    BodyParts? bodyPartsMAC,
    String? selectedBodyPartMAC,
    String? painCharacter,
    bool? addedRadiation,
    String? radiation,
    BodyParts? bodyPartsR,
    String? selectedBodyPartR,
    List<String>? associatedSymptoms,
    bool? constantPain,
    TimeOfDay? time,
    bool? clockSelectorShown,
  }) {
    return MedicalData(
      bodyPartsMAC: bodyPartsMAC ?? this.bodyPartsMAC,
      selectedBodyPartMAC: selectedBodyPartMAC ?? this.selectedBodyPartMAC,
      painCharacter: painCharacter ?? this.painCharacter,
      addedRadiation: addedRadiation ?? this.addedRadiation,
      radiation: radiation ?? this.radiation,
      bodyPartsR: bodyPartsR ?? this.bodyPartsR,
      selectedBodyPartR: selectedBodyPartR ?? this.selectedBodyPartR,
      associatedSymptoms: associatedSymptoms ?? this.associatedSymptoms,
      constantPain: constantPain ?? this.constantPain,
      time: time ?? this.time,
      clockSelectorShown: clockSelectorShown ?? this.clockSelectorShown,
    );
  }

  @override
  String toString() {
    return 'MedicalData(selectedBodyPartMAC: $selectedBodyPartMAC, painCharacter: $painCharacter, radiation: $radiation, selectedBodyPartR: $selectedBodyPartR, associatedSymptoms: $associatedSymptoms, isConstantPain: $constantPain, time: $time)';
  }

  String clockSelectorTitle() {
    return (constantPain ?? false)
        ? "How long have you been feeling the pain?"
        : "How long does each episode last?";
  }
}
