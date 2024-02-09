import 'package:equatable/equatable.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AuthorizationLogged extends AuthorizationEvent {
  final String username;
  final String password;

  const AuthorizationLogged({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthorizationLoggedOut extends AuthorizationEvent {}

class AuthorizationRegistered extends AuthorizationEvent {
  final String username;
  final String password;
  final String confirmPassword;

  const AuthorizationRegistered({required this.username, required this.password, required this.confirmPassword});

  @override
  List<Object> get props => [username, password, confirmPassword];
}