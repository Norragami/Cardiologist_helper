import 'package:cardeologist_helper/data/local/database.dart';
import 'package:flutter/material.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';

import '../../../domain/methods.dart';
import '../widgets/navigation_drawer.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key, required this.patient, required this.files});
  final Patient? patient;
  final List<PlatformFile>? files;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Анализ сигналов'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Пациент: ${patient?.name ?? 'Пациент не выбран'} ${patient?.lastname ?? ''} ${patient?.patronymic ?? ''}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    width: 500,
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: ListView.builder(
                      itemCount: files?.length,
                      itemBuilder: (_, i) {
                        return ListTile(
                          title: Text(files?[i].name ?? "No name"),
                          subtitle: Text(files?[i].path ?? "No path"),
                          onTap: () {
                            loadCSVData(files?[i].path).then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value[0][0]),
                                )
                              )
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
