import 'dart:async';
import 'dart:convert';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/params.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/data/models/user_update.dart';
import 'package:band_app/features/user/domain/usecases/get_user.dart';
import 'package:band_app/features/user/domain/usecases/get_users.dart';
import 'package:band_app/features/user/domain/usecases/update_user.dart';
import 'package:band_app/features/user/presentation/bloc/users_event.dart';
import 'package:band_app/features/user/presentation/bloc/users_state.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UsersBloc(this.getUsersUseCase, this.getUserUseCase, this.updateUserUseCase) : super(UsersLoadInProgress()){
    on<UsersLoaded>(_onUsersLoaded);
    on<UserLoaded>(_onUserLoaded);
    on<UserUpdated>(_onUserUpdated);
  }



  void _onUsersLoaded(UsersLoaded event, Emitter<UsersState> emit) async {
      final result = await getUsersUseCase();

      if(result is DataSuccess) {
        emit(UsersLoadSuccess(result.data!));
      }else{
        emit(const UsersLoadFailure("Nepodařilo se načíst uživatele"));
      }
  }

  void _onUserLoaded(UserLoaded event, Emitter<UsersState> emit) async {
    emit(UserLoadInProgress(state.users));

    final result = await getUserUseCase(params: event.id);

    if(result is DataSuccess) {
      emit(UserLoadSuccess(state.users, result.data!));
    }else {
      emit(UserLoadFailure("Nepodařilo se načíst uživatele", state.users));
    }

  }

  void _onUserUpdated(UserUpdated event, Emitter<UsersState> emit) async {
    if(event.username.length < 4 && event.username.isNotEmpty){
      return;
    }

    if(event.password.length < 8 && event.password.isNotEmpty){
      return;
    }


    UserUpdateModel userUpdate = UserUpdateModel(
      username: event.username.isEmpty ? null : event.username,
      password: event.password.isEmpty ? null : sha512.convert(utf8.encode(event.password)).toString(),
    );


    final result = await updateUserUseCase(params: UpdateUserParams(id: event.id, userUpdate: userUpdate));

    if(result is DataSuccess) {

      List<UserModel> users =  List.from(state.users);

      users[users.indexWhere((element) => element.id == event.id)] = result.data!;

      emit(UserUpdateSuccess(users, result.data!));
    }else {
      emit(UserUpdateFailure("Nepodařilo se upravit uživatele", state.users));
    }

  }
}