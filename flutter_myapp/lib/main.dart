import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myapp/api/firebase_api.dart';
import 'package:flutter_myapp/app.dart';
import 'package:flutter_myapp/location_service.dart';
import 'package:flutter_myapp/observer.dart';
import 'package:flutter_myapp/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  Bloc.observer = const Observer();
  WidgetsFlutterBinding.ensureInitialized();
  LocationService().requestPermission();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  PushNotification().init();
  runApp(App(authenticationRepository: AuthenticationRepository()));
}
