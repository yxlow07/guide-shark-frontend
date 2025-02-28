import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/data/MedicalDataCubit.dart';
import 'package:guide_shark/data/MedicalDataState.dart';
import '../../common/widgets/SingleChoiceSelection.dart';

class PainCharacter {
  Widget painCharacter(MedicalDataCubit cubit) {
    List<String> options = [
      'Crushing (Pressure)',
      'Stabbing (Sharp)',
      'Burning (Heat)',
      'Throbbing (Pulsating)',
      'Aching (Dull)',
      'Tingling (Pins and Needles)',
      'Numbness',
      'Itching (Swelling/Inflammation/Redness)',
    ];

    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChoiceSelection().build(
              context: context,
              options: options,
              selectedValue: state.formData.painCharacter,
              onSelected: (val) => cubit.updatePainType(val),
              title: 'What is the character of your pain?',
            ),
          ),
        );
      },
    );
  }
}
