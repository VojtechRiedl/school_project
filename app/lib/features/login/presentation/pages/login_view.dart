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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _usernameController.text = "Admin";
    _passwordController.text = "admin123";
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
        //backgroundColor: Palette.dark,
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
                    Text("Art Of The Crooked",style: Theme.of(context).textTheme.headlineLarge/*extStyle(/*color: Palette.darkTextColor*/ fontSize: 32, fontWeight: FontWeight.bold)*/),
                    const SizedBox(height: 40),
                    Input(label: "Uživatelské jméno", isObscured: false, controller: _usernameController, errorText: authorizationBloc.state is AuthorizationLoginFailure && (authorizationBloc.state as AuthorizationLoginFailure).error == AuthorizationError.badUsername ? (authorizationBloc.state as AuthorizationLoginFailure).message : null),
                    const SizedBox(height: 10),
                    Input(
                        label: "Heslo",
                        isObscured: true,
                        controller: _passwordController,
                        errorText:  authorizationBloc.state is AuthorizationLoginFailure && (authorizationBloc.state as AuthorizationLoginFailure).error == AuthorizationError.badPassword ? (authorizationBloc.state as AuthorizationLoginFailure).message : null),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Palette.light)),
                            onPressed: (){
                              if(authorizationBloc.state is! AuthorizationAuthenticateInProgress){
                                GoRouter.of(context).pushNamed("register");
                              }
                            },
                            child: Text("Nemáš účet?", style: Theme.of(context).textTheme.bodyMedium)),
                      ],
                    )
                  ]
              ),
              const Spacer(flex: 1),

              ElevatedButton(
                onPressed: (){
                  context.read<AuthorizationBloc>().add(
                      AuthorizationLogged(
                          username: _usernameController.text,
                          password: _passwordController.text
                      )
                  );
                },
                child: authorizationBloc.state is AuthorizationAuthenticateInProgress ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)) : const Text("Přihlásit se", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ),

              const Spacer(flex: 1),
            ]
        )
    );
  }
}