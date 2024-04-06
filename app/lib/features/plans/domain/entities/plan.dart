import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class PlanEntity extends Equatable{

  final int id;
  final String title;
  final String ? description;
  final DateTime date;
  final UserModel user;

  const PlanEntity({required this.id, required this.title, this.description, required this.date, required this.user});

  @override
  List<Object?> get props => [id, title, description, date, user];

}