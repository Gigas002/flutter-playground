import 'package:flutter/material.dart';
import 'package:flutter_myapp/widgets/title_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        customTitle: const Text("Settings Page"),
        context: context
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
