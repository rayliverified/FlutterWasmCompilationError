import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData themeData = ThemeData(
  visualDensity: VisualDensity.compact,

  // Fixes uneven width of scrollbar when hovered
  scrollbarTheme: ScrollbarThemeData(thickness: MaterialStateProperty.all(4)),

  // Assigns the system status bar colors for both android and ios to dark
  // colors for contrast against this light theme.
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),

  //text
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 44,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  ),

  sliderTheme: SliderThemeData(
    thumbShape: const ThumbShape(),
    trackShape: TrackShape(),
    overlayColor: Colors.transparent,
    thumbColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
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

// **Themes**
//

class UnhighlightedTextButtonTheme extends StatelessWidget {
  const UnhighlightedTextButtonTheme({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
      ),
      child: child,
    );
  }
}

class IconTextButtonTheme extends StatelessWidget {
  const IconTextButtonTheme({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
        ),
      ),
      child: child,
    );
  }
}

class ExplicitTheme extends InheritedWidget {
  const ExplicitTheme({
    super.key,
    required super.child,
    required this.theme,
  });

  final ExplicitThemeData theme;

  static ExplicitTheme of(BuildContext context) {
    final ExplicitTheme? result =
        context.dependOnInheritedWidgetOfExactType<ExplicitTheme>();
    assert(result != null, 'No ExplicitTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ExplicitTheme oldWidget) => theme != oldWidget.theme;
}

class ExplicitThemeData with Diagnosticable {
  const ExplicitThemeData.raw({
    required this.green,
    required this.purple,
    required this.bluish,
    required this.lightGrey,
    required this.whiteShade,
    required this.grey,
    required this.spotlightColor,
    required this.lightGreen,
  });

  factory ExplicitThemeData() => const ExplicitThemeData.raw(
        green: Colors.green,
        purple: Colors.purple,
        bluish: Colors.blue,
        lightGrey: Colors.grey,
        whiteShade: Colors.white,
        grey: Colors.grey,
        spotlightColor: Colors.yellow,
        lightGreen: Colors.lightGreen,
      );

  final Color green;
  final Color purple;
  final Color bluish;
  final Color lightGrey;
  final Color whiteShade;
  final Color grey;
  final Color spotlightColor;
  final Color lightGreen;
}

// END: Themes
