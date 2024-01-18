import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:get_it/get_it.dart';

import 'domain/repositories/repository.dart';
import 'presentation/UI/pages/home_page.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

import 'presentation/cubits/patient/cubit/patient_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<Repository>(Repository());

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(800, 700),
      size: Size(1400, 800),
      center: true,
      backgroundColor: Colors.transparent,
      // skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'Приложение для работы врача-кардиолога',
      windowButtonVisibility: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PatientCubit()),
          ],
          child: child!,
        );
      },
      supportedLocales: [
        Locale('ru'),
      ],
    );
  }
}
