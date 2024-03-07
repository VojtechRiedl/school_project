import 'package:band_app/core/constants/enums.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthorizationState extends Equatable {
  final UserModel ? user;


  const AuthorizationState({this.user});

  @override
  List<Object?> get props => [user];
}


class AuthorizationLogoutSuccess extends AuthorizationState {}

class AuthorizationAuthenticateInProgress extends AuthorizationState {}

class AuthorizationRegisterFailure extends AuthorizationState {
  final AuthorizationError error;
  final String message;

  const AuthorizationRegisterFailure(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class AuthorizationLoginFailure extends AuthorizationState {
  final AuthorizationError error;
  final String message;

  const AuthorizationLoginFailure(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class AuthorizationAuthenticateSuccess extends AuthorizationState {

  const AuthorizationAuthenticateSuccess(user) : super(user: user);

  @override
  List<Object?> get props => [user];
}
