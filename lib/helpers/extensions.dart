import 'package:example/themes/theme_data.dart';
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ExplicitThemeData get explicitTheme => ExplicitTheme.of(this).theme;
}

extension MaterialAppExtensions on MaterialApp {
  /// Returns a material app with an additional explicit theme alongside the
  /// material theme data.
  Widget get withExplicitTheme {
    return ExplicitTheme(
      theme: ExplicitThemeData(),
      child: this,
    );
  }
}
