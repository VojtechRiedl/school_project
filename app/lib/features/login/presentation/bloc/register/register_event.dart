import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent{
  final String username;
  final String password;
  final String confirmPassword;

  const RegisterUser({
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [username, password, confirmPassword];
}