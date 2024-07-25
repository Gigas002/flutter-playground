import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_code/app.dart';
import 'package:native_code/observer.dart';

Future<void> main() async {
  Bloc.observer = const Observer();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
