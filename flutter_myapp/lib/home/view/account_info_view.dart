import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_myapp/camera/camera.dart';
import 'package:flutter_myapp/location_service.dart';
import 'package:flutter_myapp/push_notification.dart';

class AccountInfoView extends StatelessWidget {
  const AccountInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Localizations.override(
                context: context,
                locale: const Locale('ru'),
                child: Text(AppLocalizations.of(context)!.helloWorld),
              ),
              ElevatedButton(
                child: const Text("Push"),
                onPressed: () => PushNotification().showNotification(
                  title: "Hello from push!",
                  body: "Huyodi",
                )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.helloWorld),
              ElevatedButton(
                child: const Text("Popup"),
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text("My Simple Dialog"),
                      children: [
                        const Text("test"),
                        TextButton(
                          child: const Text('Approve'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Camera"),
              ElevatedButton(
                child: const Text("Camera"),
                onPressed: () => Navigator.pushNamed(context, CameraPage.route),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Location"),
              ElevatedButton(
                child: const Text("Location"),
                onPressed: () => LocationService().getCurrentLocation(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
