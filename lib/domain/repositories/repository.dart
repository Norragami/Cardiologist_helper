import 'package:drift/drift.dart';

import '../../data/local/database.dart';

class Repository {
  AppDb database = AppDb();

  Stream<List<Patient>> getPatients() =>
      database.select(database.patients).watch();



      Future<List<Patient>> getPatientsWithSearch(String query) async {
  return (
    database.select(database.patients)
      ..where((u) => u.name.like('%$query%') | u.lastname.like('%$query%')
  )).get();
}


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

  Future<bool> updateContacts(Contact contact) =>
      database.update(database.contacts).replace(contact);
      

  void deletePatientSignalsWithPatientId(int id) =>
      (database.delete(database.patientSignals)
            ..where((tbl) => tbl.patientId.equals(id)))
          .go();
  void deletePatientContactsWithpatientId(int id) =>
      (database.delete(database.contacts)
            ..where((tbl) => tbl.patientId.equals(id)))
          .go();

  Future <List<PatientSignal>> getpatientsSignalsWithpatientId(int id) =>
  (database.select(database.patientSignals)
        ..where((tbl) => tbl.patientId.equals(id)))
      .get();
  
  Future <List<Contact>> getContactsWithPatientId(int id) =>
  (database.select(database.contacts)
        ..where((tbl) => tbl.patientId.equals(id)))
      .get();


deletePatient(Patient patient) =>
      database.delete(database.patients).delete(patient);






}
