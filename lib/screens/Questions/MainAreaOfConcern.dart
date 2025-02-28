import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/data/MedicalDataCubit.dart';
import 'package:guide_shark/data/MedicalDataState.dart';
import '../../common/widgets/BodyPartSelector.dart';

class MainAreaOfConcern {
  Widget mainAreaOfConcern(MedicalDataCubit cubit) {
    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BodyPartSelector().build(
                context: context,
                bodyParts: state.formData.bodyPartsMAC,
                selectedBodyPart: state.formData.selectedBodyPartMAC,
                onSelected:
                    (bodyPart, bodyParts) =>
                        cubit.updateBodyPartMAC(bodyPart, bodyParts),
                title: 'Select your main area of concern',
              ),
            ),
          ),
        );
      },
    );
  }
}
