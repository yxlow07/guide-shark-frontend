import 'package:flutter/material.dart';
import 'dart:math';

class ClockPainter extends CustomPainter {
  final TimeOfDay time;

  ClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    // Draw clock face
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);

    // Draw border
    final borderPaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    canvas.drawCircle(center, radius, borderPaint);

    // Draw hour marks
    for (int i = 0; i < 12; i++) {
      final angle = i * 2 * pi / 12;
      final markLength = i % 3 == 0 ? 0.15 * radius : 0.1 * radius;
      final markStart = Offset(
        centerX + cos(angle) * (radius - markLength),
        centerY + sin(angle) * (radius - markLength),
      );
      final markEnd = Offset(
        centerX + cos(angle) * radius * 0.9,
        centerY + sin(angle) * radius * 0.9,
      );
      canvas.drawLine(markStart, markEnd, borderPaint);
    }

    // Calculate hour and minute hand angles
    final hourAngle =
        (time.hour % 12 + time.minute / 60) * 2 * pi / 12 - pi / 2;
    final minuteAngle = time.minute * 2 * pi / 60 - pi / 2;

    // Draw hour hand
    final hourHandPaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(hourAngle) * radius * 0.5,
        centerY + sin(hourAngle) * radius * 0.5,
      ),
      hourHandPaint,
    );

    // Draw minute hand
    final minuteHandPaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(minuteAngle) * radius * 0.7,
        centerY + sin(minuteAngle) * radius * 0.7,
      ),
      minuteHandPaint,
    );
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => time != oldDelegate.time;
}
