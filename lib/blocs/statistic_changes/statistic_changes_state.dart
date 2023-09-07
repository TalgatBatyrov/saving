part of 'statistic_changes_cubit.dart';

@freezed
class StatisticChangesState with _$StatisticChangesState {
  const factory StatisticChangesState.waiting() = _Waiting;
  const factory StatisticChangesState.remowed(Statistic statistic) = _Remowed;
  const factory StatisticChangesState.updated(Statistic statistic) = _Updated;
}
