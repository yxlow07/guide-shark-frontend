import 'package:flutter/cupertino.dart';
import 'package:guide_shark/data/MedicalDataCubit.dart';

import '../screens/Questions/AssociatedSymptoms.dart';
import '../screens/Questions/ClockSelector.dart';
import '../screens/Questions/MainAreaOfConcern.dart';
import '../screens/Questions/PainCharacter.dart';
import '../screens/Questions/PainSlider.dart';
import '../screens/Questions/Radiation.dart';
import '../screens/Questions/Relief.dart';
import '../screens/Questions/TimingSelector.dart';

class Questions {
  static List<Widget> getQuestions(MedicalDataCubit cubit) {
    return [
      MainAreaOfConcern().mainAreaOfConcern(cubit),
      PainCharacter().painCharacter(cubit),
      Radiation().radiation(cubit),
      AssociatedSymptoms().associatedSymptoms(cubit),
      TimingSelector().timingSelector(cubit),
      ClockSelector().clockSelector(cubit),
      PainSlider().painSlider(cubit),
      Relief().relief(cubit),
    ];
  }
}
