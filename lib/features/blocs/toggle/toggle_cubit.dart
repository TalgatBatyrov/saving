import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ToogleCubit extends Cubit<bool> {
  ToogleCubit() : super(false);

  void toggle() => emit(!state);
}

class ToggleVisibilityChangeGoalCubit extends ToogleCubit {
  ToggleVisibilityChangeGoalCubit() : super();
}
