part of 'signal_cubit.dart';

@freezed
class SignalState with _$SignalState {
  const factory SignalState.initial() = _Initial;
  const factory SignalState.loaded(List<PatientSignal> files) = _Loaded;
  const factory SignalState.print(List<List<dynamic>> data) = _Print;
}
