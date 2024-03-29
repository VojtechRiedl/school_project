import 'package:band_app/core/constants/enums.dart';
import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_cubit.dart';
import 'package:band_app/features/home/presentation/bloc/internet/internet_state.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_event.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/login/presentation/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends  StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if(state is InternetConnectionFailure){
              context.pushNamed('connection-lost');
            }
          },
        ),
        BlocListener<AuthorizationBloc,AuthorizationState>(
          listener: (context, state) {
            if(state is AuthorizationAuthenticateSuccess){
              context.goNamed("home");
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.light,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    AuthorizationBloc authorizationBloc = context.watch<AuthorizationBloc>();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              Column(
                  children: [
                    const Text("Art Of The Crooked",style: TextStyle(color: Palette.darkTextColor, fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 40),
                    Input(
                        label: "Uživatelské jméno",
                        isObscured: false,
                        controller: _usernameController ,
                        errorText: authorizationBloc.state is AuthorizationRegisterFailure && (authorizationBloc.state as AuthorizationRegisterFailure).error == AuthorizationError.badUsername ? (authorizationBloc.state as AuthorizationRegisterFailure).message : null
                    ),
                    const SizedBox(height: 10),
                    Input(
                        label: "Heslo",
                        isObscured: true,
                        controller: _passwordController,
                        errorText: authorizationBloc.state is AuthorizationRegisterFailure && (authorizationBloc.state as AuthorizationRegisterFailure).error == AuthorizationError.badPassword ? (authorizationBloc.state as AuthorizationRegisterFailure).message : null
                    ),
                    const SizedBox(height: 10),
                    Input(
                        label: "Potvrzení hesla",
                        isObscured: true,
                        controller: _confirmPasswordController ,
                        errorText: authorizationBloc.state is AuthorizationRegisterFailure && (authorizationBloc.state as AuthorizationRegisterFailure).error == AuthorizationError.badPassword ? (authorizationBloc.state as AuthorizationRegisterFailure).message : null
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                              if(authorizationBloc.state is! AuthorizationAuthenticateInProgress){
                                GoRouter.of(context).pop("login");
                              }
                            },
                            child: const Text("Máš již účet?", style: TextStyle(color: Palette.darkTextColor, fontSize: 14, fontWeight: FontWeight.bold))),
                      ],
                    )
                  ]
              ),
              const Spacer(flex: 1),
              Card(
                elevation: 0.5,
                child: ListTile(
                  tileColor: Palette.dark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  title: const Text("Zaregistrovat se", textAlign: TextAlign.center, style: TextStyle(color: Palette.yellow, fontSize: 16, fontWeight: FontWeight.bold)),
                  onTap: (){

                    context.read<AuthorizationBloc>().add(
                        AuthorizationRegistered(
                            username: _usernameController.value.text,
                            password: _passwordController.value.text,
                            confirmPassword: _confirmPasswordController.value.text
                        )
                    );
                  },
                ),
              ),
              const Spacer(flex: 1),
            ]
        )
    );
  }

  /*Widget _buildBody(BuildContext context){
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state is RegisterSuccess){
          GoRouter.of(context).pushReplacementNamed('home');
        }
      },
      builder: (BuildContext context, RegisterState state) {
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
                        Input(label: "Uživatelské jméno", obscured: false, controller: _usernameController ,errorText: state is UsernameError ? state.message : null),
                        const SizedBox(height: 10),
                        Input(label: "Heslo", obscured: true,controller: _passwordController, errorText: state is PasswordError ? state.message : null),
                        const SizedBox(height: 10),
                        Input(label: "Potvrzení hesla", obscured: true,controller: _confirmPasswordController ,errorText: state is PasswordError ? state.message : null),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (){
                                  GoRouter.of(context).pushNamed('login');
                                },
                                child: const Text("Máš již účet?", style: TextStyle(color: Palette.second, fontSize: 14, fontWeight: FontWeight.bold))),
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
                      title: const Text("Zaregistrovat se", textAlign: TextAlign.center, style: TextStyle(color: Palette.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      onTap: (){
                        context.read<RegisterBloc>().add(
                            RegisterUser(
                                username: _usernameController.value.text,
                                password: _passwordController.value.text,
                                confirmPassword: _confirmPasswordController.value.text
                            )
                        );
                      },
                    ),
                  ),
                  const Spacer(flex: 1),
                ]
            )
        );
      },
    );
  }*/
}