import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void init(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;
    final initialState = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(initialState);
  }

  void toggleTheme() {
    final isLight = state == ThemeMode.dark;
    emit(isLight ? ThemeMode.light : ThemeMode.dark);
  }
}
