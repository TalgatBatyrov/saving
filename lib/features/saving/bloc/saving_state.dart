import 'package:equatable/equatable.dart';

import '../../../repositories/savings/models/saving.dart';

abstract class SavingState extends Equatable {
  const SavingState();

  @override
  List<Object> get props => [];
}

class SavingInitial extends SavingState {}

class SavingLoading extends SavingState {}

class SavingLoaded extends SavingState {
  final List<Saving> savings;

  const SavingLoaded({required this.savings});

  @override
  List<Object> get props => [savings];
}

class SavingError extends SavingState {
  final String message;

  const SavingError(this.message);

  @override
  List<Object> get props => [message];
}

class SavingEmpty extends SavingState {}
