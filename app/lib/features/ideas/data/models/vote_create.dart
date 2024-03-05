import 'package:intl/intl.dart';

class VoteCreateModel {
  final int ideaId;
  final int userId;
  final bool like;

  VoteCreateModel({
    required this.ideaId,
    required this.userId,
    required this.like,
  });


  Map<String, dynamic> toJson() {
    return {
      'idea_id': ideaId,
      'user_id': userId,
      'like': like,
    };
  }

}