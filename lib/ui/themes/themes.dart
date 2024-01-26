import 'package:flutter/material.dart';

abstract class Themes {
  static ThemeData get light => ThemeData.light(useMaterial3: true).copyWith(
        textTheme: ThemeData.light(useMaterial3: true).textTheme.copyWith(
              bodyMedium: const TextStyle(color: Colors.black),
            ),
        cardTheme: const CardTheme(color: Colors.white),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      );

  static ThemeData get dark => ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: ThemeData.dark(useMaterial3: true).textTheme.copyWith(
              bodyMedium: const TextStyle(color: Colors.white),
            ),
        scaffoldBackgroundColor: Colors.black87,
        cardTheme: CardTheme(color: Colors.grey.withOpacity(0.22)),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      );
}
