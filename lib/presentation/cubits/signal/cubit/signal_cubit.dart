import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cardeologist_helper/data/local/database.dart';
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../domain/repositories/repository.dart';

part 'signal_state.dart';
part 'signal_cubit.freezed.dart';

class SignalCubit extends Cubit<SignalState> {
  SignalCubit() : super(SignalState.initial());

  Repository repository = GetIt.I.get<Repository>();

  void getFiles(Patient patient) {
    repository
        .getFiles(patient)
        .then((value) => emit(SignalState.loaded(value)));
  }

  Future<List<List<dynamic>>> loadCSVData(path) async {
    final file = File(path).openRead();
    return await file
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(eol: '\n', textDelimiter: ','))
        .toList();
  }

  List<FlSpot> getSpots(List<List<dynamic>> data) {
    List<FlSpot> spots = [];

    for (int i = 1; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble() / 1000, data[i][0]));
    }
    return spots;
  }

  final reportForm = fb.group({
    'diagnosis': FormControl<String>(
      value: '',
    ),
    'commentary': FormControl<String>(
      value: '',
    ),
  });

  Future<Uint8List> createReport(
      Patient patient, String? diagnosis, String? commentary) async {
    final Document doc = Document(pageMode: PdfPageMode.outlines);
    final font1 = await rootBundle.load("assets/fonts/font_regular.ttf").then((value) => Font.ttf(value));
    final font2 = await rootBundle.load("assets/fonts/font_bold.ttf").then((value) => Font.ttf(value));
    doc.addPage(
      MultiPage(
        theme: ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.portrait,
        crossAxisAlignment: CrossAxisAlignment.start,
        header: (Context context) {
          if (context.pageNumber == 1) {
            return SizedBox();
          }
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: PdfColors.grey))),
              child: Text('',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (Context context) => <Widget>[
          Header(
            level: 0,
            child: Row(
              children: [
                Expanded(
                    child: Column(children: [
                  Text(
                    'Отчет кардиологического обследования',
                    style: TextStyle(fontWeight: FontWeight.bold, font: font2),
                  ),
                  SizedBox(height: 20),
                ]))
              ],
            ),
          ),
          SizedBox(height: 10),
          Header(
            level: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Paragraph(
                        text:
'''Пациент: ${patient.lastname} ${patient.name} ${patient.patronymic ?? ''} 

Пол: ${patient.sex.toString()[0]}                          

Дата рождения: ${patient.birthday.day}.${patient.birthday.month}.${patient.birthday.year}

''',
style: TextStyle(font: font1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Header(
            level: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Paragraph(
                        text:
'''Диагноз: ${diagnosis??''}

Рекомендации: ${commentary?? ''}
                         
''',
                      )
                    ],
                  )
                )
              ]
            )
          ),
           Spacer(),
          Row(
            children: [
              Expanded(
                child: Text('Дата: ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}'),

              ),
              Spacer(),
              Expanded(
                child: Text('Подпись: _________________', style: TextStyle(font: font1)),
              ),
              
            ]
          ),
        ],
      ),
    );
    doc.save().then((value) async{
      final folder = await getApplicationDocumentsDirectory();
      final file = File(p.join(folder.path, '${patient.name}_${patient.lastname}.pdf'));
      file.writeAsBytesSync(value);
    });
    return await doc.save();
  }
}
