
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/patient/cubit/patient_cubit.dart';
import '../widgets/navigation_drawer.dart';
import 'add_patient_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var patientCubit = context.read<PatientCubit>();
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Реестр пациентов'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    width: 24.0,
                  ),
                  // const Text(
                  //   'Пациенты',
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                  Container(
                    width: 500,
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10, 0),
                    child: ReactiveForm(
                      
                      formGroup: patientCubit.queryForm,
                      child: ReactiveTextField<String>(
                        formControlName: 'query',
                        onChanged: (control) => patientCubit.searchPatient(patientCubit.queryForm.control('query').value),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Поиск по имени и фамилии',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color:Colors.blue),
                          )
                        ),
                      ),
                    ),
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: BlocBuilder<PatientCubit, PatientState>(
                      builder: (context, state) => state.when(
                        initial: () => const CircularProgressIndicator(),
                        success: (items) => items.isEmpty
                            ? const Center(child: Text('Нет пациентов'))
                            : Container(
                                height: 400,
                                // child: SingleChildScrollView(
                                //   child: DataTable(
                                //     columns:const [
                                //       DataColumn(label: Text('Фамилия')),
                                //       DataColumn(label: Text('Имя')),
                                //       DataColumn(label: Text('Отчество')),
                                //       DataColumn(label: Text('Пол')),
                                //       DataColumn(label: Text('Дата рождения')),
                                //     ],
                                //     rows: [
                                //       DataRow(cells:[
                                //         DataCell(Text(items[0].lastname)),
                                //         DataCell(Text(items[0].name)),
                                //         DataCell(Text(items[0].patronymic??'')),
                                //         DataCell(Text(items[0].sex)),
                                //         DataCell(Text('${items[0].birthday.day}.${items[0].birthday.month}.${items[0].birthday.year}')),
                                  
                                //       ]),
                                //     ],
                                                  
                                //   ),
                                // ),
                                child: ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (context, index) => ListTile(
                                    shape: const RoundedRectangleBorder(
                                      // borderRadius: BorderRadius.
                                      side:  BorderSide(
                                        color: Colors.blue,
                                        width: 0.5,
                                      )
                                    ),
                                    title: Text(
                                        '${items[index].lastname} ${items[index].name} ${items[index].patronymic??'                        '}             Пол: ${items[index].sex}              Дата рождения: ${items[index].birthday.day}.${items[index].birthday.month}.${items[index].birthday.year}'),
                                    // subtitle: Text(items[index].lastname),
                                    onTap: () {
                                      patientCubit.selectPatient(items[index]);
                                       showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: double.maxFinite,
                                  width: 1500,
                                  color: Colors.blue.shade400,
                                  child:  AddPatientPage(id:items[index].id),
                                ),
                              );
                            });
                                    },
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          patientCubit
                                              .deletePatient(items[index]);
                                        }),
                                  ),
                                ),
                              ),
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
