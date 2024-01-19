import 'dart:io';

import 'package:flutter/material.dart';


import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;
import 'package:printing/printing.dart';

import '../../../data/local/database.dart';


class ReportPage extends StatelessWidget {
  const ReportPage({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отчет кардиологического обследования'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body:  Center(child: PDFViewer(patient: patient)),
    );
  }
}

class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PdfPreview(
        build: (context) async {
          final folder = await getApplicationDocumentsDirectory();
          final file = await File(p.join(folder.path, '${patient.name}_${patient.lastname}.pdf')).readAsBytes();
          return file;
        }
      ),
    );
  }
}