import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';
import '../../common/widgets/BodyPartSelector.dart';

class RadiationLocation {
  Widget radiationLocation(MedicalDataCubit cubit) {
    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BodyPartSelector().build(
                context: context,
                bodyParts: state.formData.bodyPartsR,
                selectedBodyPart: state.formData.selectedBodyPartR,
                onSelected:
                    (bodyPart, bodyParts) =>
                        cubit.updateSelectedBodyPartR(bodyPart, bodyParts),
                title: 'Select where the pain radiates to',
              ),
            ),
          ),
        );
      },
    );
  }
}
