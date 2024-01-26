import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_connection_state.dart';
part 'internet_connection_cubit.freezed.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  late final StreamSubscription _internetSubscription;

  InternetConnectionCubit() : super(const InternetConnectionState.initial()) {
    _internetSubscription = InternetConnectionChecker()
        .onStatusChange
        .listen(_onInternetConnectionChanged);
  }

  void _onInternetConnectionChanged(InternetConnectionStatus status) {
    if (status == InternetConnectionStatus.disconnected) {
      emit(const InternetConnectionState.disconnected());
      return;
    }
    emit(const InternetConnectionState.connected());
  }

  @override
  Future<void> close() {
    _internetSubscription.cancel();
    return super.close();
  }
}
