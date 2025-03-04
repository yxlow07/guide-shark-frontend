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
  double painSliderValue;
  Map<String, bool>? reliefMethods;

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
    this.painSliderValue = 0.0,
    this.reliefMethods,
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
    double? painSliderValue,
    Map<String, bool>? reliefMethods,
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
      painSliderValue: painSliderValue ?? this.painSliderValue,
      reliefMethods: reliefMethods ?? this.reliefMethods,
    );
  }

  @override
  String toString() {
    List<String> data = [
      'Main Area of Concern: $selectedBodyPartMAC',
      'Pain Character: $painCharacter',
      radiation != null
          ? (radiation == 'Yes' ? 'Radiation: Yes, it radiates to $selectedBodyPartR' : 'Radiation: No')
          : '',
      "Associated Symptoms: ${associatedSymptoms?.join(", ")}",
      'Constant Pain: $constantPain',
      '${clockSelectorTitle()}: ${time.hour} hours ${time.minute} minutes',
      'Pain Severity (1-10): $painSliderValue',
      "Pain is relieved by: ${reliefMethods?.entries.where((e) => e.value).map((e) => e.key).join(", ")}",
    ];
    return data.join('\n');
  }

  String clockSelectorTitle() {
    return (constantPain ?? false) ? 'How long have you been feeling the pain?' : 'How long does each episode last?';
  }
}
