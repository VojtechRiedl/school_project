import 'package:band_app/features/ideas/domain/entities/vote.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/domain/entities/user.dart';

class VoteModel extends VoteEntity {
  const VoteModel({
    required bool accepted,
    required UserEntity author,
  }) : super(
    accepted: accepted,
    author: author,
  );



  factory VoteModel.fromJson(Map<String, dynamic> map){
    return VoteModel(
      accepted: map['accepted'],
      author: UserModel.fromJson(map['user']),
    );
  }
}