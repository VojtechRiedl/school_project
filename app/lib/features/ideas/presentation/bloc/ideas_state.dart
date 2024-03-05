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

