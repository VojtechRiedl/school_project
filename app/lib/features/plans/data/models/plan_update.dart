class PlanUpdateModel {
  final String title;
  final DateTime date;
  final String ? description;

  PlanUpdateModel({
    required this.title,
    required this.date,
    this.description,
  });


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
    };
  }

}