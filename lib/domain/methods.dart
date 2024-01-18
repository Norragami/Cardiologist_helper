import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

Future<List<List>> loadCSVData(path) async {
  final  file = File(path).openRead();
  return await file.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
}
  // const CsvToListConverter().convert(await File(path).readAsString());
  
