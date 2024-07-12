import 'package:flutter/material.dart';
import 'package:flutter_myapp/settings/settings.dart';

class TitleBar extends AppBar {
  final Widget customTitle;
  final BuildContext context;

  TitleBar({super.key, required this.customTitle, required this.context})
      : super(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Navigation menu',
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.lightBlueAccent,
          titleTextStyle: const TextStyle(color: Colors.white),
          title: customTitle,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage())
                );
              },
            )
          ],
        );
}
