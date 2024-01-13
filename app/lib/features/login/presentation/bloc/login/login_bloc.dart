import 'dart:convert';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/usecases/login.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_event.dart';
import 'package:band_app/features/login/presentation/bloc/login/login_state.dart';
import 'package:band_app/features/user/domain/usecases/save_user.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  final LoginUseCase _loginUseCase;
  final SaveUserUseCase _saveUserUseCase;

  LoginBloc(this._loginUseCase, this._saveUserUseCase) : super(const LoginInitial()){
    on<LoginUser>(_onLogin);
  }

  void _onLogin(LoginUser event, Emitter<LoginState> emit) async{
    
    final password = sha512.convert(utf8.encode(event.password)).toString();

    final AuthorizationModel authorization = AuthorizationModel(
      username: event.username,
      hashedPassword: password,
    );

    final result = await _loginUseCase(params: authorization);

    if(result is DataSuccess) {
      await _saveUserUseCase(params: result.data);
      emit(const LoginSuccess());
    }
    else {
      emit(const PasswordError("Špatné uživatelské jméno nebo heslo"));
    }
  }



}