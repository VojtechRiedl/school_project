import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:equatable/equatable.dart';

abstract class IdeasState extends Equatable {
  final List<IdeaModel> ideas;

  const IdeasState({this.ideas = const []});

  @override
  List<Object> get props => [ideas];
}

class IdeasInitial extends IdeasState {}

class IdeasLoadInProgress extends IdeasState {}

class IdeasLoadSuccess extends IdeasState {
  const IdeasLoadSuccess(List<IdeaModel> ideas) : super(ideas: ideas);

  @override
  List<Object> get props => [ideas];
}

class IdeasLoadFailure extends IdeasState {

  const IdeasLoadFailure();

  @override
  List<Object> get props => [];
}

class IdeasVoteSuccess extends IdeasState {

  const IdeasVoteSuccess(List<IdeaModel> ideas) : super(ideas: ideas);

  @override
  List<Object> get props => [ideas];
}

class IdeasVoteFailure extends IdeasState {
  final String message;

  const IdeasVoteFailure(List<IdeaModel> ideas, this.message) : super(ideas: ideas);

  @override
  List<Object> get props => [message, ideas];
}

class IdeasCreateSuccess extends IdeasState {

  const IdeasCreateSuccess(List<IdeaModel> ideas) : super(ideas: ideas);

  @override
  List<Object> get props => [ideas];
}

class IdeasCreateFailure extends IdeasState {
  final String message;

  const IdeasCreateFailure(List<IdeaModel> ideas, this.message) : super(ideas: ideas);

  @override
  List<Object> get props => [message, ideas];
}

class IdeasDeleteSuccess extends IdeasState {

  const IdeasDeleteSuccess(List<IdeaModel> ideas) : super(ideas: ideas);

  @override
  List<Object> get props => [ideas];
}

class IdeasDeleteFailure extends IdeasState {
  final String message;

  const IdeasDeleteFailure(List<IdeaModel> ideas, this.message) : super(ideas: ideas);

  @override
  List<Object> get props => [message, ideas];
}
