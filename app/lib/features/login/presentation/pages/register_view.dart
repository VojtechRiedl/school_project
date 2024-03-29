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
                    Text("Art Of The Crooked",style: Theme.of(context).textTheme.headlineLarge),
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
                            child: Text("Máš již účet?", style: Theme.of(context).textTheme.bodyMedium)),
                      ],
                    )
                  ]
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                  onPressed: (){
                    context.read<AuthorizationBloc>().add(
                        AuthorizationRegistered(
                            username: _usernameController.value.text,
                            password: _passwordController.value.text,
                            confirmPassword: _confirmPasswordController.value.text
                        )
                    );
                  },
                  child: authorizationBloc.state is AuthorizationAuthenticateInProgress ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)) : const Text("Zaregistrovat se", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ),

              const Spacer(flex: 1),
            ]
        )
    );
  }

}