part of 'patient_cubit.dart';

@freezed
class PatientState with _$PatientState {
  const factory PatientState.initial() = _Initial;
  const factory PatientState.success(List<Patient> patients) = _Success;
}
