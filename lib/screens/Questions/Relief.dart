import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/common/AppStyles.dart';
import 'package:guide_shark/common/widgets/MultiChoiceSelection.dart';
import 'package:guide_shark/common/widgets/Question.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';

class Relief {
  Widget relief(MedicalDataCubit cubit) {
    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        Map<String, bool> selection =
            state.formData.reliefMethods ??
            {
              "Rest": false,
              "Movement": false,
              "Medication": false,
              "Applying Heat": false,
              "Cooling the area": false,
              "Massage": false,
              "Nothing helps with it": false,
            };

        return Question.build("Is your symptoms relieved by..", [
          Text("Select all that apply", style: AppStyles.hint),
          MultiChoiceSelection().build(
            context: context,
            options: selection,
            onSelected: (val) {
              Map<String, bool> updatedSelection = Map.from(val);

              if (val["Nothing helps with it"] == true) {
                updatedSelection.forEach((key, value) {
                  if (key != "Nothing helps with it") {
                    updatedSelection[key] = false;
                  }
                });
              }
              cubit.updateReliefMethods(updatedSelection);
            },
          ),
        ]);
      },
    );
  }
}
