import 'package:band_app/core/constants/enums.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthorizationState extends Equatable {

  const AuthorizationState();

  @override
  List<Object> get props => [];
}


class LogoutState extends AuthorizationState {}

class AuthorizationLoadingState extends AuthorizationState {}

class RegistrationErrorState extends AuthorizationState {
  final AuthorizationError error;
  final String message;

  const RegistrationErrorState(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class LoginErrorState extends AuthorizationState {
  final AuthorizationError error;
  final String message;

  const LoginErrorState(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class AuthorizationSuccessState extends AuthorizationState {
  final UserModel user;

  const AuthorizationSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class LoginSuccessState extends AuthorizationState {}

class RegisterSuccessState extends AuthorizationState {}
