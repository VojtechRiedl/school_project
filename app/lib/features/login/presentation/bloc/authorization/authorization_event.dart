import 'package:equatable/equatable.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthorizationEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends AuthorizationEvent {}

class RegisterEvent extends AuthorizationEvent {
  final String username;
  final String password;
  final String confirmPassword;

  const RegisterEvent({required this.username, required this.password, required this.confirmPassword});

  @override
  List<Object> get props => [username, password, confirmPassword];
}