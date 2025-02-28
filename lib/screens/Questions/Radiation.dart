import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/common/widgets/SingleChoiceSelection.dart';
import '../../common/AppColors.dart';
import '../../common/AppStyles.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';
import '../../common/helpers/camelCaseToCapitalize.dart';
import 'package:group_button/group_button.dart';
import '../../common/widgets/BodyPartSelector.dart';

class Radiation {
  void addPages(String val, MedicalDataCubit cubit) {
    if (val == 'Yes') {
      cubit.addRadiationLocationPage();
    } else {
      cubit.removeRadiationLocationPage();
    }
  }

  Widget radiation(MedicalDataCubit cubit) {
    List<String> selection = ["Yes", "No"];

    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChoiceSelection().build(
                  context: context,
                  options: selection,
                  selectedValue: state.formData.radiation,
                  onSelected: (val) {
                    cubit.updateRadiation(val);
                    addPages(val, cubit);
                  },
                  title:
                      'Does the pain radiate to other locations in your body?',
                ),
              ],
            ),
          ),
        );
      },
      bloc: cubit,
    );
  }
}
