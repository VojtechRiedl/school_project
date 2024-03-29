import 'package:band_app/features/user/data/models/user_update.dart';
import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersLoaded extends UsersEvent {}

class UserLoaded extends UsersEvent {
  final int id;

  const UserLoaded(this.id);

  @override
  List<Object> get props => [id];
}

class UserUpdated extends UsersEvent {
  final int id;
  final String password;
  final String username;

  const UserUpdated(this.id, this.username, this.password);

  @override
  List<Object> get props => [id, username, password];
}