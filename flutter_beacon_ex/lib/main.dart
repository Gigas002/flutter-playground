import 'package:beacon_scanner/beacon_scanner.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_ex/app.dart';
import 'package:flutter_beacon_ex/observer.dart';

final BeaconScanner beaconScanner = BeaconScanner.instance;

Future<void> main() async {
  Bloc.observer = const Observer();
  WidgetsFlutterBinding.ensureInitialized();
  await beaconScanner.initialize();
  runApp(App());
}
