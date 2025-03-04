import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/common/widgets/SingleChoiceSelection.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';

class TimingSelector {
  Widget timingSelector(MedicalDataCubit cubit) {
    List<String> selection = ["Constant", "Comes and Goes"];

    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        return SingleChoiceSelection().build(
          context: context,
          options: selection,
          selectedValue:
              state.formData.constantPain == null
                  ? null
                  : selection[state.formData.constantPain! ? 0 : 1],
          onSelected: (val) {
            cubit.updatePainTimingType(val == selection[0]);
          },
          title: 'Are your symptoms..',
        );
      },
    );
  }
}
