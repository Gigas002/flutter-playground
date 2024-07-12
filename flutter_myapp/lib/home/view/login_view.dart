import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_myapp/authentication/bloc/authentication_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _passwordController = TextEditingController();

  void dispose() {
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Input password:",
              filled: true,
            ),
          ),
          ElevatedButton(
              child: const Text("Login", style: TextStyle(fontSize: 22)),
              onPressed: () {
                context.read<AuthenticationBloc>().add(AuthenticationLoginRequested(_passwordController.text));
              }),
        ],
      ),
    );
  }
}
