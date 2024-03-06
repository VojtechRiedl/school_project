import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/ideas/data/models/idea_create.dart';
import 'package:band_app/features/ideas/data/models/vote_create.dart';
import 'package:band_app/features/ideas/domain/entities/idea.dart';

abstract class IdeaRepository{

  Future<DataState<List<IdeaEntity>>> getIdeas();

  Future<DataState<IdeaEntity>> createIdea(IdeaCreateModel ideaCreate);

  Future<DataState<IdeaEntity>> createVote(VoteCreateModel voteCreate);

  Future<DataState<IdeaEntity>> deleteIdea(int id);

}