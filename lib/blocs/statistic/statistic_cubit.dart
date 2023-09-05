import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repositories/savings/models/saving.dart';
import '../../repositories/statistics/abstract_statistics_repository.dart';
import '../../repositories/statistics/models/statistic.dart';

part 'statistic_cubit.freezed.dart';
part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final AbstractStatisticsRepository _statisticsRepository;

  StatisticCubit(this._statisticsRepository)
      : super(const StatisticState.loading());

  void getStatistics(Saving saving) async {
    emit(const StatisticState.loading());

    final statistics = await _statisticsRepository.getStatisticsList(saving);
    if (statistics.isEmpty) {
      emit(const StatisticState.empty());
      return;
    }
    emit(StatisticState.loaded(statistics: statistics));
  }

  Future<void> addStatistic({
    required String savingId,
    required int money,
  }) async {
    await _statisticsRepository.addStatistic(
      savingId: savingId,
      money: money,
    );
  }

  Future<void> deleteStatistic(Saving saving) async {
    await _statisticsRepository.deleteStatistic(saving);
  }
}
