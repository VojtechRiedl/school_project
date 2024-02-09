import 'package:band_app/core/constants/enums.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthorizationState extends Equatable {

  const AuthorizationState();

  @override
  List<Object> get props => [];
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
  final UserModel user;

  const AuthorizationAuthenticateSuccess(this.user);

  @override
  List<Object> get props => [user];
}
