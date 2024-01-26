import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saving/features/statistic/bloc/statistic/statistic_cubit.dart';
import 'package:saving/features/statistic/repository/abstract_statistics_repository.dart';
import 'package:saving/features/statistic/repository/statistics_repository.dart';

void main() {
  group('StatisticCubit', () {
    AbstractStatisticsRepository statisticsRepository;
    late StatisticCubit statisticCubit;

    setUp(() {
      statisticsRepository = StatisticsRepository(FirebaseFirestore.instance);
      statisticCubit = StatisticCubit(statisticsRepository);
    });

    test('initial state is loading', () {
      expect(statisticCubit.state, const StatisticState.loading());
    });

    // test('getStatistics emits loaded state when successful', () async {
    //   final saving = Saving(); // Создайте тестовые данные
    //   final fakeStatistics = [Statistic(money: 100), Statistic(money: 200)];
    //   when(statisticsRepository.getStatisticsList(saving))
    //       .thenAnswer((_) async => fakeStatistics);

    //   await statisticCubit.getStatistics(saving);

    //   expect(statisticCubit.state, StatisticState.loaded(statistics: fakeStatistics));
    // });

    // test('getStatistics emits empty state when statistics are empty', () async {
    //   final saving = Saving();
    //   when(statisticsRepository.getStatisticsList(saving)).thenAnswer((_) async => []);

    //   await statisticCubit.getStatistics(saving);

    //   expect(statisticCubit.state, const StatisticState.empty());
    // });

    // // Тесты для addStatistic и deleteStatistic могут быть похожими

    tearDown(() {
      statisticCubit.close();
    });
  });
}
