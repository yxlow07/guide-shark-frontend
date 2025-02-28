import 'package:body_part_selector/body_part_selector.dart';

class MedicalData {
  // Main Area of Concern MAC
  BodyParts bodyPartsMAC;
  String? selectedBodyPartMAC;
  String? painCharacter;
  // Radiation R
  String? radiation;
  BodyParts bodyPartsR;
  String? selectedBodyPartR;

  MedicalData({
    BodyParts? bodyPartsMAC,
    this.selectedBodyPartMAC,
    this.painCharacter,
    this.radiation,
    BodyParts? bodyPartsR,
    this.selectedBodyPartR,
  }) : bodyPartsMAC = bodyPartsMAC ?? BodyParts(),
       bodyPartsR = bodyPartsR ?? BodyParts();

  MedicalData copyWith({
    BodyParts? bodyPartsMAC,
    String? selectedBodyPartMAC,
    String? painCharacter,
    String? radiation,
    BodyParts? bodyPartsR,
    String? selectedBodyPartR,
  }) {
    return MedicalData(
      bodyPartsMAC: bodyPartsMAC ?? this.bodyPartsMAC,
      selectedBodyPartMAC: selectedBodyPartMAC ?? this.selectedBodyPartMAC,
      painCharacter: painCharacter ?? this.painCharacter,
      radiation: radiation ?? this.radiation,
      bodyPartsR: bodyPartsR ?? this.bodyPartsR,
      selectedBodyPartR: selectedBodyPartR ?? this.selectedBodyPartR,
    );
  }

  @override
  String toString() {
    return 'MedicalData(selectedBodyPartMAC: $selectedBodyPartMAC, painCharacter: $painCharacter, radiation: $radiation, selectedBodyPartR: $selectedBodyPartR)';
  }
}
