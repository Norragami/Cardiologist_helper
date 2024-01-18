import 'package:cardeologist_helper/data/local/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubits/patient/cubit/patient_cubit.dart';
import '../../cubits/signal/cubit/signal_cubit.dart';
import '../widgets/navigation_drawer.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key, required this.patient});
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    var patientCubit = context.read<PatientCubit>();
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
                    child: BlocBuilder<SignalCubit, SignalState>(
                        builder: (context, state) => state.when(
                            initial: () => const Text('Файлы отсутствуют'),
                            print: (p0) => const Text ('Файлы отсутствуют'),
                            loaded: (files) => ListView.builder(
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(files[index].fileName),
                                    onTap: () {
                                      signalCubit.loadCSVData(files[index].fileName)
                                          .then((value) {
                                            signalCubit.emit(SignalState.print(value));
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
                children: [
                  const SizedBox(
                    height: 42,
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
                          loaded: (files) => const Text('Выберите файл для отображения'),
                          print: (data)=> ScaffoldMessenger(child: Text(data[2][1].toString())),

                          // SizedBox(
                          //   height: 400,
                          //   child: LineChart(
                          //     LineChartData(
                          //       lineBarsData: [
                          //         LineChartBarData(
                          //           spots: [FlSpot(0, data[1][0]), FlSpot(1, data[2][0])],
                          //         )
                          //       ]
                          //     )
                          //   )
                          // )
                        )
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
