import 'package:band_app/features/ideas/data/models/vote.dart';
import 'package:band_app/features/ideas/domain/entities/idea.dart';
import 'package:band_app/features/ideas/domain/entities/vote.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

class IdeaModel extends IdeaEntity {
  const IdeaModel({
    required int id,
    required String title,
    required String description,
    required UserEntity author,
    required DateTime created,
    required DateTime deadline,
    required List<VoteEntity> votes,
  }) : super(
        id: id,
        title: title,
        description: description,
        author: author,
        created: created,
        deadline: deadline,
        votes: votes,
      );


  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: UserModel.fromJson(json['user']),
      created: DateTime.parse(json['created']),
      deadline: DateTime.parse(json['deadline']),
      votes: (json['votes'] as List).map((e) => VoteModel.fromJson(e)).toList(),
    );
  }
}