import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/data/models/vote_create.dart';
import 'package:band_app/features/ideas/domain/repository/idea_repository.dart';

class CreateVoteUseCase extends UseCase<DataState<IdeaModel>,VoteCreateModel>{
  final IdeaRepository _ideaRepository;

  CreateVoteUseCase(this._ideaRepository);

  @override
  Future<DataState<IdeaModel>> call({VoteCreateModel ? params}) {
    return _ideaRepository.createVote(params!) as Future<DataState<IdeaModel>>;
  }
}