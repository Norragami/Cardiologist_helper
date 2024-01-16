import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Анализ сигналов'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade400,
        ));
  }
}
