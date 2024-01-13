import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState{
  const LoginInitial();
}

class PasswordError extends LoginState{
  final String ? message;

  const PasswordError(this.message);

  @override
  List<Object> get props => [message!];
}

class LoginSuccess extends LoginState{
  const LoginSuccess();
}