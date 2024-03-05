import 'package:band_app/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class VoteEntity extends Equatable {

  final bool accepted;
  final UserEntity author;

  const VoteEntity({required this.accepted, required this.author});

  @override
  List<Object> get props => [accepted, author];
}