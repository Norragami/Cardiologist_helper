import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cardeologist_helper/data/local/database.dart';
import 'package:csv/csv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';


import '../../../../domain/repositories/repository.dart';

part 'signal_state.dart';
part 'signal_cubit.freezed.dart';

class SignalCubit extends Cubit<SignalState> {
  SignalCubit() : super(SignalState.initial());

 Repository repository = GetIt.I.get<Repository>();

  void getFiles (Patient patient) {

    repository
        .getFiles(patient).then((value) => emit(SignalState.loaded(value)));
  }


Future<List<List<dynamic>>> loadCSVData(path) async {
  final  file = File(path).openRead();
  return await file.transform(utf8.decoder).transform(const CsvToListConverter( eol: '\n', textDelimiter: ',')).toList();
}
}
