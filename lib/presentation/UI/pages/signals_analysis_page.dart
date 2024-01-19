import 'package:cardeologist_helper/data/local/database.dart';
import 'package:cardeologist_helper/presentation/UI/pages/report_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/signal/cubit/signal_cubit.dart';
import '../widgets/navigation_drawer.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {

    var signalCubit = context.read<SignalCubit>();
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
                  " Пациент: ${patient.name} ${patient.lastname} ${patient.patronymic ?? ''}",
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
                    child: BlocBuilder<SignalCubit, SignalState>(
                        builder: (context, state) => state.when(
                            initial: () => const Text('Файлы отсутствуют'),
                            print: (p0) => SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero),
                                      ))),
                                      onPressed: () {
                                        signalCubit.getFiles(patient);
                                      },
                                      child: const Text('Выбрать другой файл')),
                                ),
                            loaded: (files) => ListView.builder(
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(files[index].fileName),
                                    onTap: () {
                                      signalCubit
                                          .loadCSVData(files[index].fileName)
                                          .then((value) {
                                        signalCubit
                                            .emit(SignalState.print(value));
                                      });
                                    },
                                  );
                                }))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 44,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: BlocBuilder<SignalCubit, SignalState>(
                      builder: (context, state) => state.when(
                        initial: () => const Text('Файлы отсутствуют'),
                        loaded: (files) => const Text('Выберите файл '),
                        print: (data) => SizedBox(
                          height: 350,
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: const AxisTitles(
                                  axisNameSize: 30,
                                  axisNameWidget: Text('Время, с'),
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                  ),
                                ),
                                leftTitles: const AxisTitles(
                                  axisNameSize: 20,
                                  axisNameWidget: Text('Амплитуда, усл. ед.'),
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 50,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 20,
                                    getTitlesWidget: (index, meta) =>
                                        const Text(' '),
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 20,
                                    getTitlesWidget: (value, meta) =>
                                        const Text(' '),
                                  ),
                                ),
                              ),
                              minY: -0.20,
                              maxY: 0.50,
                              lineBarsData: [
                                LineChartBarData(
                                  color: const Color.fromARGB(255, 66, 165, 245),
                                  dotData: const FlDotData(show: false),
                                  isCurved: true,
                                  spots: signalCubit.getSpots(data),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ReactiveForm(
                      formGroup: signalCubit.reportForm,
                      child: Column(
                        children: [
                          ReactiveTextField(
                            formControlName: 'diagnosis',
                            decoration: const InputDecoration(
                              labelText: 'Диагноз',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: ReactiveTextField(
                              maxLines: 3,
                              formControlName: 'commentary',
                              decoration: const InputDecoration(
                                labelText: 'Рекомендации',
                                border: OutlineInputBorder(),
                              ),
                            ),

                          ),
                          const SizedBox(
                            height: 10.0,
                          )
                          ,
                          Expanded(
                            child: ElevatedButton(

                              onPressed: () {
                                
                                signalCubit.createReport(patient, signalCubit.reportForm.control('diagnosis').value, signalCubit.reportForm.control('commentary').value).then((value) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ReportPage(patient: patient)));
                                });
                                
                                // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ReportPage(patient: patient)));
                              },
                              child: const Text('Создать отчёт'),
                            ),
                          ),
                          const Expanded(
                            child:  SizedBox(
                              height: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
