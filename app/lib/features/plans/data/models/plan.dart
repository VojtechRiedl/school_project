import 'package:band_app/features/plans/domain/entities/plan.dart';
import 'package:band_app/features/user/data/models/user.dart';

class PlanModel extends PlanEntity{

  const PlanModel({
    required int id,
    required String title,
    String ? description,
    required DateTime date,
    required UserModel user
  }) : super(
        id: id,
        title: title,
        description: description,
        date: date,
        user: user
      );
  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: DateTime.parse(json['date']),
    user: UserModel.fromJson(json['user'])
  );

}