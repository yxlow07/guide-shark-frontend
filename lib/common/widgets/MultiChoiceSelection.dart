import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:guide_shark/common/AppStyles.dart';

class MultiChoiceSelection {
  Widget build({
    required BuildContext context,
    required Map<String, bool> options,
    required Function(Map<String, bool>) onSelected,
  }) {
    final controller = GroupButtonController(
      selectedIndexes:
          options.entries
              .where((e) => e.value)
              .map((e) => options.keys.toList().indexOf(e.key))
              .toList(),
    );

    return Column(
      children: [
        GroupButton(
          controller: controller,
          buttons: options.keys.toList(),
          onSelected: (val, idx, isSelectionMade) {
            options[val] = isSelectionMade;
            onSelected(options);
          },
          isRadio: false,
          options: AppStyles.gbo(context),
        ),
      ],
    );
  }
}
