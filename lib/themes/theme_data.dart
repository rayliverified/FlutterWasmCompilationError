import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData themeData = ThemeData(
  sliderTheme: SliderThemeData(
    thumbShape: const ThumbShape(),
    trackShape: TrackShape(),
  ),
);

// BEGIN: Slider

class ThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const ThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    Paint fillPaint = Paint()
      ..color = sliderTheme!.thumbColor!
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}

class TrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    RenderBox? parentBox,
    Offset? offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    final double thumbWidth =
        sliderTheme!.thumbShape!.getPreferredSize(true, isDiscrete!).width;
    final double trackHeight = sliderTheme.trackHeight!;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox!.size.width >= thumbWidth);
    assert(parentBox!.size.height >= trackHeight);

    const double paddingLeft = 0;
    const double paddingRight = 0;

    final double trackLeft = (offset!.dx + thumbWidth / 2);
    final double trackTop =
        offset.dy + (parentBox!.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - thumbWidth;
    return Rect.fromLTWH(
      trackLeft + paddingLeft,
      trackTop,
      trackWidth - paddingRight * 2,
      trackHeight,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    Animation<double>? enableAnimation,
    TextDirection? textDirection,
    Offset? thumbCenter,
    bool? isDiscrete,
    bool? isEnabled,
    Offset? secondaryOffset,
  }) {
    if (sliderTheme?.trackHeight == 0) {
      return;
    }

    final Canvas canvas = context.canvas;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint inactivePaint = Paint()
      ..color = sliderTheme!.inactiveTrackColor!
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint activePaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path inactiveSegment = Path()
      ..moveTo(trackRect.left, thumbCenter!.dy)
      ..lineTo(trackRect.right, thumbCenter.dy);

    Path activeSegment = Path()
      ..moveTo(trackRect.left, thumbCenter.dy)
      ..lineTo(thumbCenter.dx, thumbCenter.dy);

    canvas.drawPath(inactiveSegment, inactivePaint);
    canvas.drawPath(activeSegment, activePaint);
  }
}

// END: Slider
