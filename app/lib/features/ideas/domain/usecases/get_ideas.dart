import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/domain/repository/idea_repository.dart';

class GetIdeasUseCase extends UseCase<DataState<List<IdeaModel>>,void>{
  final IdeaRepository _ideaRepository;

  GetIdeasUseCase(this._ideaRepository);

  @override
  Future<DataState<List<IdeaModel>>> call({void params}) {
    return _ideaRepository.getIdeas() as Future<DataState<List<IdeaModel>>>;
  }
}