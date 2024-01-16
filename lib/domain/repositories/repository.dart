import 'package:drift/drift.dart';

import '../../data/local/database.dart';

class Repository {
  AppDb database = AppDb();

  Stream<List<Patient>> getPatients() =>
      database.select(database.patients).watch();

  Future<int> insertPatient(Patient patient) =>
      database.into(database.patients).insert(PatientsCompanion.insert(
            name: patient.name,
            lastname: patient.lastname,
            patronymic: Value(patient.patronymic),
            birthday: patient.birthday,
            sex: patient.sex,
          ));

  Future<int> insertContacts(Contact contact) =>
      database.into(database.contacts).insert(ContactsCompanion.insert(
            patientId: contact.patientId,
            phone: contact.phone,
            email: Value(contact.email),
          ));

  Future<int> insertPatientSignal(PatientSignal patientSignal) => database
      .into(database.patientSignals)
      .insert(PatientSignalsCompanion.insert(
          patientId: patientSignal.patientId,
          fileName: patientSignal.fileName,
          eventDate: patientSignal.eventDate));

  Future<bool> updatePatient(Patient patient) =>
      database.update(database.patients).replace(patient);

  void deletePatientSignalsWithPatientId(int id) =>
      (database.delete(database.patientSignals)
            ..where((tbl) => tbl.patientId.equals(id)))
          .go();
}
