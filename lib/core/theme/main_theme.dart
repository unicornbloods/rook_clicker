import 'package:flutter/material.dart';

/// Provides the theme data for the my application.
class MyThemeData {
  const MyThemeData._();

  /// Returns the [ThemeData] for my application.
  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      useSystemColors: true,

      colorScheme: colorScheme,

      // Default button data
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          enableFeedback: true,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: true,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          enableFeedback: true,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          enableFeedback: true,
        ),
      ),

      // Default loading indicator data
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        year2023: false,
      ),

      splashFactory: InkRipple.splashFactory,

      // Use the new page transition. Addresses performance issues.
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const FadeForwardsPageTransitionsBuilder(),
        ),
      ),
    );
  }
}
