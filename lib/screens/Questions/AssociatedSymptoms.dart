import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/common/AppStyles.dart';
import 'package:guide_shark/common/widgets/Question.dart';
import 'package:guide_shark/data/MedicalDataState.dart';
import 'package:guide_shark/data/MedicalDataCubit.dart';

class AssociatedSymptoms {
  Widget associatedSymptoms(MedicalDataCubit cubit) {
    List<String> symptoms = [
      "Nausea",
      "Vomiting",
      "Diarrhea",
      "Shortness of Breath",
      "Excessive Sweating",
      "Dizziness",
      "Coughing up blood",
    ];

    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        List<String> selectedSymptoms = state.formData.associatedSymptoms ?? [];

        return Question.build(
          "Select all the associated symptoms that may apply.",
          [
            Autocomplete<String>(
              fieldViewBuilder: (
                context,
                textEditingController,
                focusNode,
                onFieldSubmitted,
              ) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Enter symptom here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                    if (value.isNotEmpty && !selectedSymptoms.contains(value)) {
                      cubit.addAssociatedSymptoms(value);
                    }
                  },
                );
              },
              optionsBuilder: (TextEditingValue txt) {
                if (txt.text == '') {
                  return symptoms;
                }
                return symptoms
                    .where(
                      (symptom) => symptom.toLowerCase().contains(
                        txt.text.toLowerCase(),
                      ),
                    )
                    .toList();
              },
              onSelected: (String selection) {
                if (!selectedSymptoms.contains(selection)) {
                  selectedSymptoms.add(selection);
                  cubit.addAssociatedSymptoms(selection);
                }
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 180.0,
                      width: 280.0,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return InkWell(
                            onTap: () {
                              onSelected(option);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(option),
                                  const Icon(
                                    Icons.add,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            Text("Type enter or press to insert.", style: AppStyles.hint),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  selectedSymptoms.asMap().entries.map((entry) {
                    int index = entry.key;
                    String symptom = entry.value;
                    return Chip(
                      label: Text(symptom),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.0),
                      ),
                      onDeleted: () {
                        cubit.removeAssociatedSymptoms(symptom);
                      },
                      deleteIcon: const Icon(Icons.delete),
                    );
                  }).toList(),
            ),
          ],
        );
      },
    );
  }
}
