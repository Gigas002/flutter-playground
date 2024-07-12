import 'package:flutter/material.dart';
import 'package:flutter_myapp/home/home.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_myapp/notification/notification.dart';
import 'package:flutter_myapp/camera/camera.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  const App({super.key, required AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: "Flutter demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ru'),
        home: const HomePage(),
        routes: {
          NotificationPage.route: (context) => const NotificationPage(),
          CameraPage.route: (context) => const CameraPage(),
        },
      ),
    );
  }
}
