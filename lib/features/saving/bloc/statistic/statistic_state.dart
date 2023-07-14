import 'package:equatable/equatable.dart';

import '../../../../repositories/savings/models/statistic/statistic.dart';

abstract class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object?> get props => [];
}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticLoaded extends StatisticState {
  final List<Statistic> statistics;
  const StatisticLoaded({required this.statistics});

  int get totalPrice {
    return statistics.fold<int>(
      0,
      (previousValue, element) => previousValue + element.money,
    );
  }

  double get averagePrice => totalPrice / statistics.length;

  @override
  List<Object> get props => [statistics];
}

class StatisticError extends StatisticState {
  final String message;
  const StatisticError({required this.message});

  @override
  List<Object> get props => [message];
}
