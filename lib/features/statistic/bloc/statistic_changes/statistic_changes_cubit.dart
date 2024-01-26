import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saving/features/statistic/repository/models/statistic/statistic.dart';

part 'statistic_changes_cubit.freezed.dart';
part 'statistic_changes_state.dart';

/// шина событий изменения статистики (удаление, изменение)
class StatisticChangesCubit extends Cubit<StatisticChangesState> {
  StatisticChangesCubit() : super(const StatisticChangesState.waiting());

  /// отправить сигнал удаления статистики
  void sendRemoveSignal(Statistic statistic) {
    emit(StatisticChangesState.remowed(statistic));
  }

  /// отправить сигнал изменения статистики
  void sendUpdateSignal(Statistic statistic) {
    emit(StatisticChangesState.updated(statistic));
  }
}
