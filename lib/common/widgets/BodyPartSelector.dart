import 'package:flutter/material.dart';
import 'package:body_part_selector/body_part_selector.dart';
import '../AppColors.dart';
import '../AppStyles.dart';
import '../helpers/camelCaseToCapitalize.dart';
import 'Question.dart';

class BodyPartSelector {
  Widget build({
    required BuildContext context,
    required BodyParts bodyParts,
    required String? selectedBodyPart,
    required Function(String, BodyParts) onSelected,
    required String title,
  }) {
    return Question().build(title, [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: BodyPartSelectorTurnable(
          bodyParts: bodyParts,
          onSelectionUpdated: (p) {
            String newlySelectedPart = 'None';
            p.toMap().forEach((key, value) {
              if (value) {
                newlySelectedPart = key;
              }
            });
            onSelected(newlySelectedPart, p);
          },
          labelData: const RotationStageLabelData(
            front: "Front",
            left: "Left",
            right: "Right",
            back: "Back",
          ),
          selectedColor: AppColors.primaryColor,
          unselectedColor: AppColors.grey,
        ),
      ),
      const SizedBox(height: 20),
      RichText(
        text: TextSpan(
          style: AppStyles.body,
          children: [
            const TextSpan(text: 'Selected Body Part: ', style: AppStyles.body),
            TextSpan(
              text: camelCaseToCapitalize().process(selectedBodyPart ?? 'None'),
              style: AppStyles.bodyBold,
            ),
          ],
        ),
      ),
    ]);
  }
}
