import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable{
  final int id;
  final String username;
  final DateTime createdAt;
  final DateTime lastLogin;

  const UserEntity({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.lastLogin,
  });


  @override
  List<Object> get props => [id,username,createdAt,lastLogin];
}