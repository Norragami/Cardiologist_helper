import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/patient/cubit/patient_cubit.dart';
import '../widgets/navigation_drawer.dart';
import 'add_patient_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var patientCubit = BlocProvider.of<PatientCubit>(context);
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        // title: const Text('Приложение для работы врача-кардиолога'),
        // centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: Container(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                child: Column(children: [
                  const SizedBox(
                    width: 24.0,
                  ),
                  const Text(
                    'Пациенты',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      label: const Text('Добавить пациента'),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        patientCubit.form.reset();

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: double.maxFinite,
                                  width: 1500,
                                  color: Colors.blue.shade400,
                                  child: const AddPatientPage(),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
