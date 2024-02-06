import 'dart:convert';

import 'package:band_app/core/constants/enums.dart';
import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/usecases/login.dart';
import 'package:band_app/features/login/domain/usecases/register.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_event.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;

  AuthorizationBloc(this._registerUseCase, this._loginUseCase) : super(LogoutState()){
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  void _onLogin(LoginEvent event, Emitter<AuthorizationState> emit) async {
    if(event.username.isEmpty){
      emit(const LoginErrorState("Uživatelské jméno nesmí být prázdné", AuthorizationError.badUsername));
      return;
    } else if(event.password.isEmpty){
      emit(const LoginErrorState("Heslo nesmí být prázdné", AuthorizationError.badPassword));
      return;
    }

    emit(AuthorizationLoadingState());

    final password = sha512.convert(utf8.encode(event.password)).toString();

    final AuthorizationModel authorization = AuthorizationModel(
      username: event.username,
      hashedPassword: password,
    );

    final result = await _loginUseCase(params: authorization);

    if(result is DataSuccess) {
      emit(AuthorizationSuccessState(result.data!));
    }
    else {
      emit(const LoginErrorState("Špatné uživatelské jméno nebo heslo", AuthorizationError.badPassword));
    }
  }

  void _onRegister(RegisterEvent event, Emitter<AuthorizationState> emit) async{
    if(event.username.isEmpty){
      emit(const RegistrationErrorState("Uživatelské jméno nesmí být prázdné", AuthorizationError.badUsername));
    }
    else if(event.username.length < 4){
      emit(const RegistrationErrorState("Uživatelské jméno musí mít alespoň 4 znaky", AuthorizationError.badUsername));
    }
    else if(event.password.isEmpty){
      emit(const RegistrationErrorState("Heslo nesmí být prázdné", AuthorizationError.badPassword));
    }
    else if(event.password.length < 8){
      emit(const RegistrationErrorState("Heslo musí mít alespoň 8 znaků", AuthorizationError.badPassword));
    }
    else if(event.password != event.confirmPassword){
      emit(const RegistrationErrorState("Hesla se neschodují", AuthorizationError.badPassword));
    }
    else{
      emit(AuthorizationLoadingState());

      final password = sha512.convert(utf8.encode(event.password)).toString();

      AuthorizationModel authorizationModel = AuthorizationModel(
        username: event.username,
        hashedPassword: password,
      );

      final result = await _registerUseCase(params: authorizationModel);

      if (result is DataSuccess){
        emit(AuthorizationSuccessState(result.data!));
      }else {
        emit(const RegistrationErrorState("Tento uživatel již existuje", AuthorizationError.badUsername));
      }

    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthorizationState> emit) async{
    emit(LogoutState());
  }


}