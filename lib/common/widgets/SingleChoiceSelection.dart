import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:guide_shark/common/AppStyles.dart';
import 'Question.dart';

class SingleChoiceSelection {
  Widget build({
    required BuildContext context,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelected,
    required String title,
  }) {
    final controller = GroupButtonController(
      selectedIndex:
          selectedValue != null ? options.indexOf(selectedValue) : null,
    );

    return Question().build(title, [
      GroupButton(
        controller: controller,
        buttons: options,
        onSelected: (val, idx, isSelectionMade) => onSelected(val),
        isRadio: true,
        options: AppStyles.gbo(context),
      ),
    ]);
  }
}
