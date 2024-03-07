import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  final List<UserModel> users;


  const UsersState({this.users = const []});

  @override
  List<Object> get props => [];
}

class UsersLoadInProgress extends UsersState {}

class UsersLoadSuccess extends UsersState {

  const UsersLoadSuccess(List<UserModel> users) : super(users: users);

  @override
  List<Object> get props => [users];
}

class UsersLoadFailure extends UsersState {
  final String message;

  const UsersLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserLoadInProgress extends UsersState {}

class UserLoadFailure extends UsersState {
  final String message;

  const UserLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserLoadSuccess extends UsersState {
  final UserModel user;

  const UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}