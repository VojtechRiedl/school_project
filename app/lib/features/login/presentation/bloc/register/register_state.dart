import 'package:equatable/equatable.dart';

class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState{
  const RegisterInitial();
}

class PasswordError extends RegisterState{
  final String ? message;

  const PasswordError(this.message);

  @override
  List<Object> get props => [message!];
}

class UsernameError extends RegisterState{
  final String ? message;

  const UsernameError(this.message);

  @override
  List<Object> get props => [message!];
}

class RegisterSuccess extends RegisterState{
  const RegisterSuccess();
}