import 'package:equatable/equatable.dart';

abstract class IdeaValidationState extends Equatable {
  const IdeaValidationState();

  @override
  List<Object> get props => [];
}

class IdeaValidationInitial extends IdeaValidationState {}

class IdeaValidationFailure extends IdeaValidationState {
  final String message;

  const IdeaValidationFailure(this.message);

  @override
  List<Object> get props => [message, DateTime.now()];
}

class IdeaValidationSuccess extends IdeaValidationState {
  final String title;
  final String description;
  final DateTime deadline;

  const IdeaValidationSuccess(this.title, this.description, this.deadline);

  @override
  List<Object> get props => [title, description, deadline, DateTime.now()];


}