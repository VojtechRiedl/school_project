import 'package:band_app/features/ideas/domain/entities/vote.dart';
import 'package:band_app/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class IdeaEntity extends Equatable{

  final int id;
  final String title;
  final String description;
  final UserEntity author;
  final DateTime created;
  final DateTime deadline;
  final List<VoteEntity> votes;

  const IdeaEntity({required this.id, required this.title, required this.description, required this.author, required this.created, required this.deadline, required this.votes});

  @override
  List<Object> get props => [id, title, description, author, created, deadline, votes];
}