part of 'internet_connection_cubit.dart';

@freezed
class InternetConnectionState with _$InternetConnectionState {
  const factory InternetConnectionState.initial() = _Initial;
  const factory InternetConnectionState.connected() = _Connected;
  const factory InternetConnectionState.disconnected() = _Disconnected;
}
