import 'package:band_app/core/constatns/palette.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_state.dart';
import 'package:band_app/features/login/presentation/widgets/Input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {

      },
      builder: (BuildContext context, LoginState state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 1),
                  Column(
                      children: [
                        const Icon(Icons.ac_unit, color: Palette.first, size: 128),
                        const SizedBox(height: 10),
                        const Text("Art Of The Crooked",style: TextStyle(color: Palette.second, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 40),
                        Input(label: "Uživatelské jméno", obscured: false, controller: _usernameController, errorText: null),
                        const SizedBox(height: 10),
                        Input(label: "Heslo", obscured: true, controller: _passwordController, errorText: null),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (){
                                  GoRouter.of(context).pushNamed('register');
                                },
                                child: const Text("Nemáš účet?", style: TextStyle(color: Palette.second, fontSize: 14, fontWeight: FontWeight.bold))),
                          ],
                        )
                      ]
                  ),
                  const Spacer(flex: 2),
                  Card(
                    child: ListTile(
                      tileColor: Palette.first,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      title: const Text("Přihlásit se", textAlign: TextAlign.center, style: TextStyle(color: Palette.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      onTap: (){},
                    ),
                  ),
                  const Spacer(flex: 1),
                ]
            )
        );
      },
    );
  }
}