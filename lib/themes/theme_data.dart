import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: library_prefixes
import 'colors.dart' as ExplicitColors;
import 'colors.dart';
import 'radii.dart';

final ThemeData themeData = ThemeData(
  visualDensity: VisualDensity.compact,
  // colors
  colorScheme: const ColorScheme.light(
    primary: primary,
    primaryContainer: primaryContainer,
    onPrimary: white,
    secondary: secondary,
    onSecondary: black,
    // Tertiary
    secondaryContainer: secondaryContainer,
    background: background,
    onBackground: black,
    surface: surface,
    onSurface: onSurface,
    error: error,
    onError: black,
  ),

  primaryColor: primary,
  scaffoldBackgroundColor: scaffoldBackground,
  shadowColor: shadow,
  highlightColor: black.withOpacity(0.06),

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
  ).apply(bodyColor: textPrimary, displayColor: textPrimary),

  // buttons
  buttonTheme: ButtonThemeData(
    padding: const EdgeInsets.all(4),
    focusColor: primary.withOpacity(0.1),
    highlightColor: primary.withOpacity(0.1),
    hoverColor: primaryContainer.withOpacity(0.02),
    splashColor: primary,
    shape: cardShapeBorder,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(buttonShapeBorder),
      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          // final bool isDisabled = states.contains(MaterialState.disabled);
          return const BorderSide(
            color: secondary,
            width: 1,
          );
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return secondary;
        },
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(buttonShapeBorder),
      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return secondary;
          return primary;
        },
      ),
      overlayColor: MaterialStateProperty.all(primary.withOpacity(0.1)),
      animationDuration: const Duration(milliseconds: 250),
    ),
  ),
  //**Not planning on continuing elevated buttons. We want our own custom shadow.
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(buttonShapeBorder),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return grey;
          return primary;
        },
      ),
      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
      elevation: MaterialStateProperty.all(0),
    ),
  ),
  sliderTheme: SliderThemeData(
    thumbShape: const ThumbShape(),
    trackShape: TrackShape(),
    overlayColor: Colors.transparent,
    thumbColor: Colors.white,
    inactiveTrackColor: secondary,
    activeTrackColor: primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondary.withOpacity(0.3)),
    ),
    hintStyle: const TextStyle(color: secondary),
    hoverColor: secondary.withOpacity(0.3),
    fillColor: secondary.withOpacity(0.3),
  ),

  // etc
  cardTheme: const CardTheme(
    shape: cardShapeBorder,
    elevation: 4,
  ),
  iconTheme: const IconThemeData(color: textPrimary),
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
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
        spotlightColor: ExplicitColors.spotlightColor,
        purple: ExplicitColors.purple,
        green: ExplicitColors.green,
        bluish: ExplicitColors.bluish,
        lightGrey: ExplicitColors.lightGrey,
        whiteShade: ExplicitColors.whiteShade,
        grey: ExplicitColors.grey,
        lightGreen: ExplicitColors.lightGreen,
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
