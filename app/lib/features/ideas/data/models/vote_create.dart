import 'package:intl/intl.dart';

class VoteCreateModel {
  final int ideaId;
  final int userId;
  final bool accepted;

  VoteCreateModel({
    required this.ideaId,
    required this.userId,
    required this.accepted,
  });


  Map<String, dynamic> toJson() {
    return {
      'idea_id': ideaId,
      'user_id': userId,
      'accepted': accepted,
    };
  }

}