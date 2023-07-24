part of 'statistic_cubit.dart';

@freezed
abstract class StatisticState with _$StatisticState {
  const factory StatisticState.loading() = _Loading;
  const factory StatisticState.loaded({required List<Statistic> statistics}) =
      _Loaded;
  const factory StatisticState.empty() = _Empty;
  const factory StatisticState.error(String message) = _Error;

  // среднее значение

  // int get average => maybeMap(
  //       loaded: (state) {
  //         final sum = state.statistics.fold<int>(
  //           0,
  //           (previousValue, element) => previousValue + element.money,
  //         );
  //         return sum ~/ state.statistics.length;
  //       },
  //       orElse: () => 0,
  //     );

  // List<Statistic> get comments => maybeMap(
  //       loaded: (state) => state.comments,
  //       orElse: () => [],
  //     );
}
