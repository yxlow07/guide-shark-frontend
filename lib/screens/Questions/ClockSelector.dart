import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/common/AppStyles.dart';
import 'package:guide_shark/common/widgets/Question.dart';
import '../../common/Images.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';
import 'ClockPainter.dart';

class ClockSelector {
  Widget clockSelector(MedicalDataCubit cubit) {
    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        TimeOfDay time = cubit.state.formData.time;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!state.formData.clockSelectorShown) {
            selectTime(context, cubit);
            cubit.markClockSelectorShown();
          }
        });

        return Question().build(state.formData.clockSelectorTitle(), [
          InkWell(
            child: Image.asset(Images.clock, width: 300, height: 300),
            onTap: () => selectTime(context, cubit),
          ),
          // InkWell(
          //   child: SizedBox(
          //     width: 300,
          //     height: 300,
          //     child: CustomPaint(
          //       painter: ClockPainter(time),
          //       child: Center(
          //         child: Container(
          //           width: 10,
          //           height: 10,
          //           decoration: BoxDecoration(
          //             color: Colors.black,
          //             shape: BoxShape.circle,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   onTap: () => selectTime(context, cubit),
          // ),
          SizedBox(height: 20),
          Text('Press the clock to select the time', style: AppStyles.hint),
          SizedBox(height: 20),
          Text(
            '${time.hour} hours ${time.minute} minutes',
            style: AppStyles.title,
          ),
        ]);
      },
    );
  }

  selectTime(BuildContext context, MedicalDataCubit cubit) async {
    TimeOfDay initialTime = cubit.state.formData.time;
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (selectedTime != null && selectedTime != initialTime) {
      cubit.updateClockSelector(selectedTime);
    }
  }
}
