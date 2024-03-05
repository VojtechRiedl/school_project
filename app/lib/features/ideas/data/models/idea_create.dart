import 'package:intl/intl.dart';

class IdeaCreateModel {
  final String title;
  final String description;
  final DateTime deadline;
  final int userId;

  IdeaCreateModel({
    required this.title,
    required this.description,
    required this.deadline,
    required this.userId,
  });


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': DateFormat("yyyy-MM-dd").format(deadline).toString(),
      'user_id': userId,
    };
  }

}