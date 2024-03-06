import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class IdeasEvent extends Equatable {
  const IdeasEvent();

  @override
  List<Object> get props => [];
}

class IdeasLoaded extends IdeasEvent {

  const IdeasLoaded();

  @override
  List<Object> get props => [];

}

class IdeasVoted extends IdeasEvent{
  final bool accepted;
  final IdeaModel idea;
  final UserModel user;

  const IdeasVoted(this.accepted, this.idea, this.user);

  @override
  List<Object> get props => [accepted, idea, user];
}

class IdeasCreated extends IdeasEvent{
  final String title;
  final String description;
  final DateTime deadline;
  final UserModel user;

  const IdeasCreated(this.title, this.description, this.deadline, this.user);

  @override
  List<Object> get props => [title, description, deadline, user];
}

class IdeasDeleted extends IdeasEvent{
  final IdeaModel idea;

  const IdeasDeleted(this.idea);

  @override
  List<Object> get props => [idea];
}
