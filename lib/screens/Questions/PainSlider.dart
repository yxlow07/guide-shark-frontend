import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_shark/common/widgets/Question.dart';
import '../../data/MedicalDataCubit.dart';
import '../../data/MedicalDataState.dart';

class PainSlider {
  final List<String> levelIndicators = [':D', ':)', ':|', ':(', ':('];
  final List<Color> colors = [
    Colors.green,
    Colors.lightGreenAccent,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ];

  Widget painSlider(MedicalDataCubit cubit) {
    return BlocBuilder<MedicalDataCubit, MedicalDataState>(
      bloc: cubit,
      builder: (context, state) {
        return Question.build("Please rate the severity of your symptoms", [
          SizedBox(height: 30),
          SizedBox(
            width: 250,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: _CustomThumbShape(
                  painLevel: state.formData.painSliderValue.round(),
                  indicators: levelIndicators,
                ),
                overlayShape: SliderComponentShape.noOverlay,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                trackShape: PainLevelTrackShape(colors),
                valueIndicatorColor: _getColorForPainLevel(
                  state.formData.painSliderValue.round(),
                ),
              ),
              child: Slider(
                value: state.formData.painSliderValue,
                onChanged: (value) {
                  cubit.updatePainSlider(value);
                },
                min: 0,
                max: 10,
                divisions: 10,
                label: state.formData.painSliderValue.round().toString(),
              ),
            ),
          ),
        ]);
      },
    );
  }

  _getColorForPainLevel(int level) {
    if (level <= 2) return Colors.green;
    if (level <= 4) return Colors.lightGreenAccent;
    if (level <= 6) return Colors.yellow;
    if (level <= 8) return Colors.orange;
    return Colors.red;
  }
}

class PainLevelTrackShape extends RoundedRectSliderTrackShape {
  final List<Color> colors;

  PainLevelTrackShape(this.colors);

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
    Offset? secondaryOffset,
  }) {
    if (sliderTheme.inactiveTrackColor == Colors.transparent &&
        sliderTheme.activeTrackColor == Colors.transparent) {
      final Rect trackRect = getPreferredRect(
        parentBox: parentBox,
        offset: offset,
        sliderTheme: sliderTheme,
        isEnabled: isEnabled,
        isDiscrete: isDiscrete,
      );

      final Paint gradientPaint =
          Paint()
            ..shader = LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: colors, // Green to Red gradient
            ).createShader(trackRect);

      context.canvas.drawRRect(
        RRect.fromRectAndRadius(
          trackRect,
          Radius.circular(trackRect.height / 2),
        ),
        gradientPaint,
      );
    } else {
      super.paint(
        context,
        offset,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumbCenter: thumbCenter,
        isDiscrete: isDiscrete,
        isEnabled: isEnabled,
        additionalActiveTrackHeight: additionalActiveTrackHeight,
      ); // In case you want default behaviour with colors.
    }
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final int painLevel;
  final List<String> indicators;

  _CustomThumbShape({required this.painLevel, required this.indicators});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(14.0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final radius = getPreferredSize(true, isDiscrete).width / 2;
    String base;
    Color thumbColor;

    if (painLevel <= 2) {
      base = indicators[0];
      thumbColor = Colors.green;
    } else if (painLevel <= 4) {
      base = indicators[1];
      thumbColor = Colors.lightGreenAccent;
    } else if (painLevel <= 6) {
      base = indicators[2];
      thumbColor = Colors.yellow;
    } else if (painLevel <= 8) {
      base = indicators[3];
      thumbColor = Colors.orange;
    } else {
      base = indicators[4];
      thumbColor = Colors.red;
    }

    // Draw background circle
    final backgroundPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw colored border
    final borderPaint =
        Paint()
          ..color = thumbColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius - 1.5, borderPaint);

    // Prepare and draw the emoji text
    final thumbContent = TextPainter(
      text: TextSpan(
        text: base,
        style: TextStyle(fontSize: radius * 1.0, color: Colors.black),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    thumbContent.layout();

    // Center the text properly
    final offset = Offset(
      center.dx - thumbContent.width / 2,
      center.dy - thumbContent.height / 2,
    );

    thumbContent.paint(canvas, offset);
  }
}
