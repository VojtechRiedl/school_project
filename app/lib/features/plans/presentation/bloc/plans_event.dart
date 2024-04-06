import 'package:equatable/equatable.dart';

abstract class PlansEvent extends Equatable {
  const PlansEvent();

  @override
  List<Object?> get props => [];
}

class PlansFetched extends PlansEvent {

  const PlansFetched();

  @override
  List<Object> get props => [];
}

class PlanFetched extends PlansEvent {
  final int id;

  const PlanFetched(this.id);

  @override
  List<Object> get props => [id];
}

class PlanDeleted extends PlansEvent {
  final int id;

  const PlanDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class PlanCreated extends PlansEvent {
  final String title;
  final String ? description;
  final DateTime date;
  final int userId;

  const PlanCreated(this.title, this.description, this.date, this.userId);

  @override
  List<Object?> get props => [title, description, date, userId];
}

class PlanUpdated extends PlansEvent {
  final String title;
  final String ? description;
  final DateTime date;

  const PlanUpdated(this.title, this.description, this.date);

  @override
  List<Object?> get props => [title, description, date];
}

