import 'package:flutter/material.dart';

extension BuildContextExtension<T> on BuildContext {

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;


  // text styles
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  TextStyle? get bodyExtraSmall =>
      bodySmall?.copyWith(fontSize: 10, height: 1.6, letterSpacing: .5);

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;

  TextStyle? get dividerTextSmall => bodySmall?.copyWith(
    letterSpacing: 0.5,
    fontWeight: FontWeight.w700,
    fontSize: 12.0,
  );

  TextStyle? get dividerTextLarge => bodySmall?.copyWith(
    letterSpacing: 1.5,
    fontWeight: FontWeight.w700,
    fontSize: 13.0,
    height: 1.23,
  );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
}
