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
  PatientCubit() : super(const PatientState.initial()) {
    repository
        .getPatients()
        .listen((value) => emit(PatientState.success(value)));
  }

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
        validators: [],
      ),
      'filepath': FormControl<MultiFile<String>>(
        value: const MultiFile<String>(
          files: [],
          platformFiles: [],
        ),
      ),
    },
  );

  final queryForm = fb.group({
    'query': FormControl<String>(
      value: '',
    )
  });

  void addPatient(int? id) {
    if (form.valid) {
      var item = Patient(
        id: id ?? -1,
        name: form.control('name').value,
        lastname: form.control('lastname').value,
        patronymic: form.control('patronymic').value,
        sex: form.control('sex').value == 0 ? 'Мужской' : 'Женский',
        birthday: form.control('birthday').value,
      );

      if (id == null) {
        repository.insertPatient(item).then(onPatientUpdate);
      } else {
        repository.updatePatient(item).then((value) => onPatientUpdate(id));
      }
    }
  }

  void onPatientUpdate(int patientId) {
    repository.deletePatientSignalsWithPatientId(patientId);
    repository.deletePatientContactsWithpatientId(patientId);
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
    }

    var contacts = Contact(
      id: -1,
      patientId: patientId,
      phone: form.control('phone').value,
      email: form.control('email').value,
    );

    repository.insertContacts(contacts);

    form.reset();
  }

  void deletePatient(Patient item) async {
    await repository.deletePatient(item);
    repository.deletePatientSignalsWithPatientId(item.id);
    repository.deletePatientContactsWithpatientId(item.id);
  }

  void selectPatient(Patient item) async {
    var filelist = await repository.getpatientsSignalsWithpatientId(item.id);
    var contacts = await repository.getContactsWithPatientId(item.id);
    form.control('name').value = item.name;
    form.control('lastname').value = item.lastname;
    form.control('patronymic').value = item.patronymic;
    form.control('birthday').value = item.birthday;
    form.control('sex').value = item.sex == 'Мужской' ? 0 : 1;
    form.control('phone').value = contacts[0].phone;
    form.control('email').value = contacts[0].email;
    form.control('filepath').value = MultiFile<String>(
      platformFiles: [
        ...filelist
            .map((e) => PlatformFile(path: e.fileName, name: '', size: 0)),
      ],
    );
  }

  void searchPatient(String query) async {
    repository
        .getPatientsWithSearch(query)
        .then((value) => emit(PatientState.success(value)));
  }

  List<PlatformFile> getListofFiles() {
    return (form.control('filepath').value as MultiFile<String>).platformFiles;
  }
}
