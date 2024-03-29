import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  final List<UserModel> users;
  final UserModel ? user;


  const UsersState({this.users = const [], this.user});

  @override
  List<Object?> get props => [users, user];
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

class UserLoadInProgress extends UsersState {

  const UserLoadInProgress(List<UserModel> users) : super(users: users);

  @override
  List<Object?> get props => [users];

}

class UserLoadFailure extends UsersState {
  final String message;

  const UserLoadFailure(this.message, users)  : super(users: users);

  @override
  List<Object> get props => [message, users];
}

class UserLoadSuccess extends UsersState {

  const UserLoadSuccess(users,user) : super(users: users, user: user);

  @override
  List<Object?> get props => [user, users];
}

class UserUpdateSuccess extends UsersState {

  const UserUpdateSuccess(users, user) : super(users: users, user: user);

  @override
  List<Object?> get props => [user, users];
}

class UserUpdateFailure extends UsersState {
  final String message;

  const UserUpdateFailure(this.message, users)  : super(users: users);

  @override
  List<Object> get props => [message, users];
}