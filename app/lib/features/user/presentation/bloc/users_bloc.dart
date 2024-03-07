import 'dart:async';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/user/domain/usecases/get_users.dart';
import 'package:band_app/features/user/presentation/bloc/users_event.dart';
import 'package:band_app/features/user/presentation/bloc/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersBloc(this.getUsersUseCase) : super(UsersLoadInProgress()){
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

  void _onUserLoaded(UserLoaded event, Emitter<UsersState> emit) {
  }

  void _onUserUpdated(UserUpdated event, Emitter<UsersState> emit) {
  }
}