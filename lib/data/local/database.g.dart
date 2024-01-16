// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Patients extends Table with TableInfo<Patients, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Patients(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _lastnameMeta =
      const VerificationMeta('lastname');
  late final GeneratedColumn<String> lastname = GeneratedColumn<String>(
      'lastname', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _patronymicMeta =
      const VerificationMeta('patronymic');
  late final GeneratedColumn<String> patronymic = GeneratedColumn<String>(
      'patronymic', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lastname, patronymic, sex, birthday];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lastname')) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableOrUnknown(data['lastname']!, _lastnameMeta));
    } else if (isInserting) {
      context.missing(_lastnameMeta);
    }
    if (data.containsKey('patronymic')) {
      context.handle(
          _patronymicMeta,
          patronymic.isAcceptableOrUnknown(
              data['patronymic']!, _patronymicMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    } else if (isInserting) {
      context.missing(_birthdayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lastname'])!,
      patronymic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patronymic']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex'])!,
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday'])!,
    );
  }

  @override
  Patients createAlias(String alias) {
    return Patients(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Patient extends DataClass implements Insertable<Patient> {
  final int id;
  final String name;
  final String lastname;
  final String? patronymic;
  final String sex;
  final DateTime birthday;
  const Patient(
      {required this.id,
      required this.name,
      required this.lastname,
      this.patronymic,
      required this.sex,
      required this.birthday});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lastname'] = Variable<String>(lastname);
    if (!nullToAbsent || patronymic != null) {
      map['patronymic'] = Variable<String>(patronymic);
    }
    map['sex'] = Variable<String>(sex);
    map['birthday'] = Variable<DateTime>(birthday);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      name: Value(name),
      lastname: Value(lastname),
      patronymic: patronymic == null && nullToAbsent
          ? const Value.absent()
          : Value(patronymic),
      sex: Value(sex),
      birthday: Value(birthday),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastname: serializer.fromJson<String>(json['lastname']),
      patronymic: serializer.fromJson<String?>(json['patronymic']),
      sex: serializer.fromJson<String>(json['sex']),
      birthday: serializer.fromJson<DateTime>(json['birthday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastname': serializer.toJson<String>(lastname),
      'patronymic': serializer.toJson<String?>(patronymic),
      'sex': serializer.toJson<String>(sex),
      'birthday': serializer.toJson<DateTime>(birthday),
    };
  }

  Patient copyWith(
          {int? id,
          String? name,
          String? lastname,
          Value<String?> patronymic = const Value.absent(),
          String? sex,
          DateTime? birthday}) =>
      Patient(
        id: id ?? this.id,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        patronymic: patronymic.present ? patronymic.value : this.patronymic,
        sex: sex ?? this.sex,
        birthday: birthday ?? this.birthday,
      );
  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastname: $lastname, ')
          ..write('patronymic: $patronymic, ')
          ..write('sex: $sex, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, lastname, patronymic, sex, birthday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastname == this.lastname &&
          other.patronymic == this.patronymic &&
          other.sex == this.sex &&
          other.birthday == this.birthday);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastname;
  final Value<String?> patronymic;
  final Value<String> sex;
  final Value<DateTime> birthday;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastname = const Value.absent(),
    this.patronymic = const Value.absent(),
    this.sex = const Value.absent(),
    this.birthday = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String lastname,
    this.patronymic = const Value.absent(),
    required String sex,
    required DateTime birthday,
  })  : name = Value(name),
        lastname = Value(lastname),
        sex = Value(sex),
        birthday = Value(birthday);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? lastname,
    Expression<String>? patronymic,
    Expression<String>? sex,
    Expression<DateTime>? birthday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastname != null) 'lastname': lastname,
      if (patronymic != null) 'patronymic': patronymic,
      if (sex != null) 'sex': sex,
      if (birthday != null) 'birthday': birthday,
    });
  }

  PatientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? lastname,
      Value<String?>? patronymic,
      Value<String>? sex,
      Value<DateTime>? birthday}) {
    return PatientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      patronymic: patronymic ?? this.patronymic,
      sex: sex ?? this.sex,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastname.present) {
      map['lastname'] = Variable<String>(lastname.value);
    }
    if (patronymic.present) {
      map['patronymic'] = Variable<String>(patronymic.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastname: $lastname, ')
          ..write('patronymic: $patronymic, ')
          ..write('sex: $sex, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }
}

class Contacts extends Table with TableInfo<Contacts, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Contacts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, patientId, phone, email];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
    );
  }

  @override
  Contacts createAlias(String alias) {
    return Contacts(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(patient_id)REFERENCES patients(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final int patientId;
  final String phone;
  final String? email;
  const Contact(
      {required this.id,
      required this.patientId,
      required this.phone,
      this.email});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      phone: Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patient_id']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patient_id': serializer.toJson<int>(patientId),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String?>(email),
    };
  }

  Contact copyWith(
          {int? id,
          int? patientId,
          String? phone,
          Value<String?> email = const Value.absent()}) =>
      Contact(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        phone: phone ?? this.phone,
        email: email.present ? email.value : this.email,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, phone, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.phone == this.phone &&
          other.email == this.email);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> phone;
  final Value<String?> email;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String phone,
    this.email = const Value.absent(),
  })  : patientId = Value(patientId),
        phone = Value(phone);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? phone,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? phone,
      Value<String?>? email}) {
    return ContactsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class PatientSignals extends Table
    with TableInfo<PatientSignals, PatientSignal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PatientSignals(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _eventDateMeta =
      const VerificationMeta('eventDate');
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
      'event_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, patientId, fileName, eventDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_signals';
  @override
  VerificationContext validateIntegrity(Insertable<PatientSignal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(_eventDateMeta,
          eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta));
    } else if (isInserting) {
      context.missing(_eventDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientSignal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientSignal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      eventDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}event_date'])!,
    );
  }

  @override
  PatientSignals createAlias(String alias) {
    return PatientSignals(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(patient_id)REFERENCES patients(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PatientSignal extends DataClass implements Insertable<PatientSignal> {
  final int id;
  final int patientId;
  final String fileName;
  final DateTime eventDate;
  const PatientSignal(
      {required this.id,
      required this.patientId,
      required this.fileName,
      required this.eventDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['file_name'] = Variable<String>(fileName);
    map['event_date'] = Variable<DateTime>(eventDate);
    return map;
  }

  PatientSignalsCompanion toCompanion(bool nullToAbsent) {
    return PatientSignalsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      fileName: Value(fileName),
      eventDate: Value(eventDate),
    );
  }

  factory PatientSignal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientSignal(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patient_id']),
      fileName: serializer.fromJson<String>(json['file_name']),
      eventDate: serializer.fromJson<DateTime>(json['event_date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patient_id': serializer.toJson<int>(patientId),
      'file_name': serializer.toJson<String>(fileName),
      'event_date': serializer.toJson<DateTime>(eventDate),
    };
  }

  PatientSignal copyWith(
          {int? id, int? patientId, String? fileName, DateTime? eventDate}) =>
      PatientSignal(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        fileName: fileName ?? this.fileName,
        eventDate: eventDate ?? this.eventDate,
      );
  @override
  String toString() {
    return (StringBuffer('PatientSignal(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('fileName: $fileName, ')
          ..write('eventDate: $eventDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, fileName, eventDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientSignal &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.fileName == this.fileName &&
          other.eventDate == this.eventDate);
}

class PatientSignalsCompanion extends UpdateCompanion<PatientSignal> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> fileName;
  final Value<DateTime> eventDate;
  const PatientSignalsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.eventDate = const Value.absent(),
  });
  PatientSignalsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String fileName,
    required DateTime eventDate,
  })  : patientId = Value(patientId),
        fileName = Value(fileName),
        eventDate = Value(eventDate);
  static Insertable<PatientSignal> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? fileName,
    Expression<DateTime>? eventDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (fileName != null) 'file_name': fileName,
      if (eventDate != null) 'event_date': eventDate,
    });
  }

  PatientSignalsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? fileName,
      Value<DateTime>? eventDate}) {
    return PatientSignalsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      fileName: fileName ?? this.fileName,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientSignalsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('fileName: $fileName, ')
          ..write('eventDate: $eventDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final Patients patients = Patients(this);
  late final Contacts contacts = Contacts(this);
  late final PatientSignals patientSignals = PatientSignals(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [patients, contacts, patientSignals];
}
