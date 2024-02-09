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

  AuthorizationBloc(this._registerUseCase, this._loginUseCase) : super(AuthorizationLogoutSuccess()){
    on<AuthorizationLogged>(_onLogin);
    on<AuthorizationRegistered>(_onRegister);
    on<AuthorizationLoggedOut>(_onLogout);
  }

  void _onLogin(AuthorizationLogged event, Emitter<AuthorizationState> emit) async {
    if(event.username.isEmpty){
      emit(const AuthorizationLoginFailure("Uživatelské jméno nesmí být prázdné", AuthorizationError.badUsername));
      return;
    } else if(event.password.isEmpty){
      emit(const AuthorizationLoginFailure("Heslo nesmí být prázdné", AuthorizationError.badPassword));
      return;
    }

    emit(AuthorizationAuthenticateInProgress());

    final password = sha512.convert(utf8.encode(event.password)).toString();

    final AuthorizationModel authorization = AuthorizationModel(
      username: event.username,
      hashedPassword: password,
    );

    final result = await _loginUseCase(params: authorization);

    if(result is DataSuccess) {
      emit(AuthorizationAuthenticateSuccess(result.data!));
    }
    else {
      emit(const AuthorizationLoginFailure("Špatné uživatelské jméno nebo heslo", AuthorizationError.badPassword));
    }
  }

  void _onRegister(AuthorizationRegistered event, Emitter<AuthorizationState> emit) async{
    if(event.username.isEmpty){
      emit(const AuthorizationRegisterFailure("Uživatelské jméno nesmí být prázdné", AuthorizationError.badUsername));
    }
    else if(event.username.length < 4){
      emit(const AuthorizationRegisterFailure("Uživatelské jméno musí mít alespoň 4 znaky", AuthorizationError.badUsername));
    }
    else if(event.password.isEmpty){
      emit(const AuthorizationRegisterFailure("Heslo nesmí být prázdné", AuthorizationError.badPassword));
    }
    else if(event.password.length < 8){
      emit(const AuthorizationRegisterFailure("Heslo musí mít alespoň 8 znaků", AuthorizationError.badPassword));
    }
    else if(event.password != event.confirmPassword){
      emit(const AuthorizationRegisterFailure("Hesla se neschodují", AuthorizationError.badPassword));
    }
    else{
      emit(AuthorizationAuthenticateInProgress());

      final password = sha512.convert(utf8.encode(event.password)).toString();

      AuthorizationModel authorizationModel = AuthorizationModel(
        username: event.username,
        hashedPassword: password,
      );

      final result = await _registerUseCase(params: authorizationModel);

      if (result is DataSuccess){
        emit(AuthorizationAuthenticateSuccess(result.data!));
      }else {
        emit(const AuthorizationRegisterFailure("Tento uživatel již existuje", AuthorizationError.badUsername));
      }

    }
  }

  void _onLogout(AuthorizationLoggedOut event, Emitter<AuthorizationState> emit) async{
    emit(AuthorizationLogoutSuccess());
  }


}