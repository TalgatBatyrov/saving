import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/theme/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkModeCubit = context.watch<ThemeCubit>();

    return IconButton(
      icon: Icon(
        isDarkModeCubit.state == ThemeMode.light
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
      onPressed: isDarkModeCubit.toggleTheme,
    );
  }
}
