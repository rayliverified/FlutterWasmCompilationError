import 'package:example/helpers/extensions.dart';
import 'package:example/themes/radii.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

const BoxShadow cardShadow =
    BoxShadow(color: shadow, blurRadius: 6, offset: Offset(0, 4));

const Shadow scrollbarInnerShadow =
    Shadow(color: Color(0x599e9e9e), blurRadius: 4);

const BoxShadow inputShadow =
    BoxShadow(color: mediumShadow, blurRadius: 6, offset: Offset(0, 4));

const BoxShadow darkDropShadow =
    BoxShadow(color: darkShadow, blurRadius: 12, offset: Offset(0, 4));

const BoxShadow lightCardShadow =
    BoxShadow(color: lightShadow, blurRadius: 10, offset: Offset(0, 4));

const BoxShadow dropdownShadow = BoxShadow(color: shadow, blurRadius: 12);

const BoxShadow scrollShadow = BoxShadow(color: shadow, blurRadius: 6);

const BoxDecoration defaultDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: cardBorderRadius,
  boxShadow: [cardShadow],
);

BoxDecoration contextDefaultDecoration(BuildContext context) =>
    defaultDecoration.copyWith(color: context.colorScheme.surface);

const BoxDecoration dialogDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: cardBorderRadius,
  boxShadow: [
    BoxShadow(color: shadow, blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: shadow, blurRadius: 12, offset: Offset(0, -3))
  ],
);

BoxDecoration contextInputDecoration(BuildContext context) => BoxDecoration(
      boxShadow: const [inputShadow],
      color: context.colorScheme.surface,
      borderRadius: buttonBorderRadius,
    );

BoxDecoration contextDialogDecoration(BuildContext context) =>
    defaultDecoration.copyWith(color: context.colorScheme.surface);
