import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/data/models/idea_create.dart';
import 'package:band_app/features/ideas/domain/repository/idea_repository.dart';

class CreateIdeaUseCase extends UseCase<DataState<IdeaModel>,IdeaCreateModel>{
  final IdeaRepository _ideaRepository;

  CreateIdeaUseCase(this._ideaRepository);

  @override
  Future<DataState<IdeaModel>> call({IdeaCreateModel ? params}) {
    return _ideaRepository.createIdea(params!) as Future<DataState<IdeaModel>>;
  }
}