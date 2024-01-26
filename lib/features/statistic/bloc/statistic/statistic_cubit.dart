import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/statistic/repository/abstract_statistics_repository.dart';
import 'package:saving/features/statistic/repository/models/statistic/statistic.dart';

part 'statistic_cubit.freezed.dart';
part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final AbstractStatisticsRepository _statisticsRepository;

  StatisticCubit(this._statisticsRepository)
      : super(const StatisticState.loading());

  void getStatistics(String savingId) async {
    emit(const StatisticState.loading());

    final statistics = await _statisticsRepository.getStatisticsList(savingId);
    if (statistics.isEmpty) {
      emit(const StatisticState.empty());
      return;
    }
    emit(StatisticState.loaded(statistics: statistics));
  }

  Future<int> getStatisticSummary(String savingId) async {
    final statistics = await _statisticsRepository.getStatisticsList(savingId);
    if (statistics.isEmpty) {
      return 0;
    }
    return statistics.fold<int>(
      0,
      (previousValue, element) => previousValue + element.money,
    );
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

  Future<void> editStatistic(Statistic statistic) async {
    await _statisticsRepository.editStatistic(statistic);

    final currentState = state;
    if (currentState is _Loaded) {
      final newStatistics = currentState.statistics
          .map((e) => e.id == statistic.id ? statistic : e)
          .toList();

      emit(StatisticState.loaded(statistics: newStatistics));
    }
  }

  Future<void> deleteStatistics(Saving saving) async {
    await _statisticsRepository.deleteStatistics(saving);
  }

  Future<void> deleteStatisticById(Statistic statistic) async {
    await _statisticsRepository.deleteStatisticById(statistic);

    final currentState = state;
    if (currentState is _Loaded) {
      final newStatistics = currentState.statistics
          .where((element) => element.id != statistic.id)
          .toList();

      if (newStatistics.isEmpty) {
        emit(const StatisticState.empty());
        return;
      }
      emit(StatisticState.loaded(statistics: newStatistics));
    }
  }
}
