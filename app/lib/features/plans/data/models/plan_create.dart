class PlanCreateModel {
  final String title;
  final DateTime date;
  final String ? description;
  final int userId;

  PlanCreateModel({
    required this.title,
    required this.date,
    this.description,
    required this.userId,
  });


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'user_id': userId,
    };
  }

}