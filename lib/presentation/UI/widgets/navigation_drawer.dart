import 'package:cardeologist_helper/presentation/UI/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';

import '../pages/signals_analysis_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          color: Colors.blue.shade400,
          child: ListView(padding: padding, children: [
            const SizedBox(height: 48),
            buildMenuitem(
              text: 'Главная',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuitem(
              text: 'Анализ сигналов',
              icon: Icons.timeline,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white70),
            const SizedBox(height: 24),
            buildMenuitem(
              text: 'Выход',
              icon: Icons.exit_to_app,
              onClicked: () => selectedItem(context, 2),
            ),
          ])),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ));
      case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AnalysisPage(),
          ));

      case 2:
        FlutterCloseApp.close();
    }
  }
}

Widget buildMenuitem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const color = Colors.white;
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: const TextStyle(color: color)),
    onTap: onClicked,
  );
}
