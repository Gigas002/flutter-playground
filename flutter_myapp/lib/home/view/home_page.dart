import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myapp/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_myapp/home/home.dart';
import 'package:flutter_myapp/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: context.read<AuthenticationRepository>()
      ),
      child: Scaffold(
        appBar: TitleBar(
          customTitle: const Text("My First App"),
          context: context,
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                return const AccountInfoView();
              default:
                return LoginView();
            }
          },
        )
      ),
    );
  }
}
