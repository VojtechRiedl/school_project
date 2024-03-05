import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/data/models/vote_create.dart';
import 'package:band_app/features/ideas/domain/repository/idea_repository.dart';

class DeleteIdeaUseCase extends UseCase<DataState<IdeaModel>,int>{
  final IdeaRepository _ideaRepository;

  DeleteIdeaUseCase(this._ideaRepository);

  @override
  Future<DataState<IdeaModel>> call({int ? params}) {
    return _ideaRepository.deleteIdea(params!) as Future<DataState<IdeaModel>>;
  }
}