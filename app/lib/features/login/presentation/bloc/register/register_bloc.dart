import 'dart:convert';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/usecases/register.dart';
import 'package:band_app/features/login/presentation/bloc/register/register_event.dart';
import 'package:band_app/features/login/presentation/bloc/register/register_state.dart';
import 'package:band_app/features/user/domain/usecases/save_user.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final RegisterUseCase _registerUseCase;
  final SaveUserUseCase _saveUserUseCase;

  RegisterBloc(this._registerUseCase, this._saveUserUseCase) : super(const RegisterInitial()){
    on<RegisterUser>(_onRegisterUser);
  }


  void _onRegisterUser(RegisterUser event, Emitter<RegisterState> emit) async{
    if(event.username.isEmpty){
      emit(const UsernameError("Uživatelské jméno nesmí být prázdné"));
    }
    else if(event.username.length < 4){
      emit(const UsernameError("Uživatelské jméno musí mít alespoň 4 znaky"));
    }
    else if(event.password.isEmpty){
      emit(const PasswordError("Heslo nesmí být prázdné"));
    }
    else if(event.password.length < 8){
      emit(const PasswordError("Heslo musí mít alespoň 8 znaků"));
    }
    else if(event.password != event.confirmPassword){
      emit(const PasswordError("Hesla se neschodují"));
    }
    else{
      //final password = BCrypt.hashpw(event.password, BCrypt.gensalt());

      final password = sha512.convert(utf8.encode(event.password)).toString();

      AuthorizationModel authorizationModel = AuthorizationModel(
        username: event.username,
        hashedPassword: password,
      );

      final result = await _registerUseCase(params: authorizationModel);

      if (result is DataSuccess){
        await _saveUserUseCase(params: result.data);
        emit(const RegisterSuccess());
      }else {
        emit(const UsernameError("Tento uživatel již existuje"));
      }

    }
  }

}