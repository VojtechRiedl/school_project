import 'package:equatable/equatable.dart';

abstract class ValidationState extends Equatable {

  const ValidationState();

  @override
  List<Object?> get props => [];
}

class ValidationInitial extends ValidationState {

  @override
  List<Object> get props => [];
}

class ValidationSuccess extends ValidationState {
  final String title;
  final String ? description;
  final DateTime deadline;

  const ValidationSuccess(this.title, this.description, this.deadline);

  @override
  List<Object?> get props => [title, description, deadline];
}

class ValidationFailure extends ValidationState {
  final String message;

  const ValidationFailure(this.message);

  @override
  List<Object> get props => [message];
}