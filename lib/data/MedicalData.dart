import 'package:body_part_selector/body_part_selector.dart';

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

  MedicalData({
    BodyParts? bodyPartsMAC,
    this.selectedBodyPartMAC,
    this.painCharacter,
    this.addedRadiation,
    this.radiation,
    BodyParts? bodyPartsR,
    this.selectedBodyPartR,
    this.associatedSymptoms,
  }) : bodyPartsMAC = bodyPartsMAC ?? BodyParts(),
       bodyPartsR = bodyPartsR ?? BodyParts();

  MedicalData copyWith({
    BodyParts? bodyPartsMAC,
    String? selectedBodyPartMAC,
    String? painCharacter,
    bool? addedRadiation,
    String? radiation,
    BodyParts? bodyPartsR,
    String? selectedBodyPartR,
    List<String>? associatedSymptoms,
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
    );
  }

  @override
  String toString() {
    return 'MedicalData(selectedBodyPartMAC: $selectedBodyPartMAC, painCharacter: $painCharacter, radiation: $radiation, selectedBodyPartR: $selectedBodyPartR), associatedSymptoms: $associatedSymptoms';
  }
}
