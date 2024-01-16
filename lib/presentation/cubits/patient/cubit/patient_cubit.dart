import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../data/local/database.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../UI/widgets/custom_validators.dart';

part 'patient_state.dart';
part 'patient_cubit.freezed.dart';

class PatientCubit extends Cubit<PatientState> {
  Repository repository = GetIt.I.get<Repository>();

  final form = fb.group(
    {
      'name': FormControl<String>(
        value: '',
        validators: [const RequiredCustomValidator()],
      ),
      'lastname': FormControl<String>(
        value: '',
        validators: [const RequiredCustomValidator()],
      ),
      'patronymic': FormControl<String>(
        value: '',
      ),
      'birthday': FormControl<DateTime>(
        value: DateTime.now(),
        validators: [const RequiredCustomValidator()],
      ),
      'sex': FormControl<int>(
        value: 0,
        validators: [const RequiredCustomValidator()],
      ),
      'phone': FormControl<String>(
        value: '',
        validators: [const RequiredCustomValidator()],
      ),
      'email': FormControl<String>(
        value: '',
      ),
      'filepath': FormControl<MultiFile<String>>(
        value: const MultiFile<String>(
          files: [],
          platformFiles: [],

        ),


      ),
    },
  );

  void addPatient(int? id) {
    if (form.valid) {
      var item = Patient(
        id: id ?? -1,
        name: form.control('name').value,
        lastname: form.control('lastname').value,
        patronymic: form.control('patronymic').value,
        sex: form.control('sex').value ==0? 'Мужской': 'Женский',
        birthday: form.control('birthday').value,
      );
      

      repository
          .insertPatient(item)
          .then(onPatientUpdate);



    }
  }

    void onPatientUpdate(int patientId) {
    repository.deletePatientSignalsWithPatientId(patientId);
    if (form.control('filepath').value != null) {
      var files =
          (form.control('filepath').value as MultiFile<String>).platformFiles;
      for (var element in files) {
        repository.insertPatientSignal(PatientSignal(
          patientId: patientId,
          id: -1,
          fileName: element.path!,
          eventDate: DateTime.now(),
        ));
      }
    var contacts = Contact(
        id: -1,
        patientId: patientId,
        phone: form.control('phone').value,
        email: form.control('email').value,);

    repository.insertContacts(contacts);
    
    }
    form.reset();
  }








  PatientCubit() : super(PatientState.initial()) {
    repository
        .getPatients()
        .listen((value) => emit(PatientState.success(value)));
  }
}
