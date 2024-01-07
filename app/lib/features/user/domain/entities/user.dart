import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable{
  final int id;
  final String username;
  final DateTime createdAt;
  final DateTime lastLogin;
  final bool whiteMode;

  const UserEntity({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.lastLogin,
    required this.whiteMode,
  });


  @override
  List<Object> get props => [id,username,createdAt,lastLogin,whiteMode];
}