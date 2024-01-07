import 'package:equatable/equatable.dart';

class AuthorizationEntity extends Equatable {

  final String username;
  final String hashedPassword;

  const AuthorizationEntity({
    required this.username,
    required this.hashedPassword,
  });

  @override
  List<Object> get props => [username,hashedPassword];
}