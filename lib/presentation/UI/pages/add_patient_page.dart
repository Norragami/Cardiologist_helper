import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reactive_file_picker/reactive_file_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../domain/Classes/file_picker_support.dart';
import '../../cubits/patient/cubit/patient_cubit.dart';

class AddPatientPage extends StatelessWidget {
  const AddPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PatientCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить пациента'),
        backgroundColor: Colors.blue.shade400,
        centerTitle: true,
      ),
      body: ReactiveForm(
        formGroup: cubit.form,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    width: 600.0,
                    height: 700.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        ReactiveTextField<String>(
                          formControlName: 'name',
                          decoration: const InputDecoration(
                            labelText: 'Имя',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ReactiveTextField<String>(
                          formControlName: 'lastname',
                          decoration: const InputDecoration(
                            labelText: 'Фамилия',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ReactiveTextField<String>(
                          formControlName: 'patronymic',
                          decoration: const InputDecoration(
                            labelText: 'Отчество',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ReactiveTextField<DateTime>(
                          readOnly: true,
                          formControlName: 'birthday',
                          decoration: InputDecoration(
                            hintText: 'Дата рождения',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                            suffixIcon: ReactiveDatePicker(
                              formControlName: 'birthday',
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              builder: (context, picker, child) => IconButton(
                                onPressed: picker.showPicker,
                                icon: const Icon(Icons.date_range),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                            child: ReactiveDropdownField<int>(
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              formControlName: 'sex',
                              hint: const Text('Пол'),
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text('Мужской'),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text('Женский'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    width: 600.0,
                    height: 700.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 18.0),
                        ReactiveTextField<String>(
                          formControlName: 'phone',
                          decoration: const InputDecoration(
                            labelText: 'Телефон',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        ReactiveTextField<String>(
                          formControlName: 'email',
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Container(
                          height: 218,
                          child: ReactiveFilePicker<String>(
                            formControlName: 'filepath',
                            filePickerBuilder: (pickImage, files, onChange) {
                              final items = [
                                ...files.platformFiles
                                    .asMap()
                                    .map((key, value) => MapEntry(
                                          key,
                                          ListTile(
                                            onTap: () {
                                              onChange(files.copyWith(
                                                  platformFiles:
                                                      List<PlatformFile>.from(
                                                          files.platformFiles)
                                                        ..removeAt(key)));
                                            },
                                            leading: const Icon(Icons.delete),
                                            title: PlatformFileListItem(value)
                                                .build(context),
                                          ),
                                        ))
                                    .values,
                              ];

                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder: (_, i) {
                                        return items[i];
                                      },
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: pickImage,
                                    child: const Text("Выбрать файл"),
                                  ),
                                ],
                              );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Выберите файлы с сигналами пациента',
                              border: OutlineInputBorder(),
                              helperText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (cubit.form.valid) {
                  cubit.addPatient(null);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Заполните обязательные поля'),
                  ));
                }
              },
              child: const Text('Сохранить'),
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
