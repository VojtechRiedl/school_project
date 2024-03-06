import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/data/models/idea_create.dart';
import 'package:band_app/features/ideas/data/models/vote_create.dart';
import 'package:band_app/features/ideas/domain/usecases/create_idea.dart';
import 'package:band_app/features/ideas/domain/usecases/create_vote.dart';
import 'package:band_app/features/ideas/domain/usecases/delete_idea.dart';
import 'package:band_app/features/ideas/domain/usecases/get_ideas.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_event.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeasBloc extends Bloc<IdeasEvent, IdeasState>{
  final GetIdeasUseCase getIdeasUseCase;
  final CreateVoteUseCase createVoteUseCase;
  final CreateIdeaUseCase createIdeaUseCase;
  final DeleteIdeaUseCase deleteIdeaUseCase;

  IdeasBloc(this.getIdeasUseCase, this.createVoteUseCase, this.createIdeaUseCase, this.deleteIdeaUseCase) : super(IdeasLoadInProgress()) {
    on<IdeasLoaded>(_onIdeasLoad);
    on<IdeasVoted>(_onIdeasVoted);
    on<IdeasCreated>(_onIdeasCreated);
    on<IdeasDeleted>(_onIdeasDeleted);
  }

  void _onIdeasLoad(IdeasLoaded event, Emitter<IdeasState> emit) async {

    final DataState<List<IdeaModel>> dataState = await getIdeasUseCase();

    if(dataState is DataSuccess) {
      emit(IdeasLoadSuccess(dataState.data!));
    }else{
      emit(const IdeasLoadFailure());
    }

  }

  void _onIdeasVoted(IdeasVoted event, Emitter<IdeasState> emit) async {

    final VoteCreateModel voteCreateModel = VoteCreateModel(
      accepted: event.accepted,
      ideaId: event.idea.id,
      userId: event.user.id,
    );

    final DataState<IdeaModel> dataState = await createVoteUseCase(params: voteCreateModel);

    if(dataState is DataSuccess){

      List<IdeaModel> ideas = List.from(state.ideas);


      int index = ideas.indexWhere((element) => element.id == event.idea.id);
      ideas.remove(ideas[index]);
      ideas.insert(index, dataState.data!);

      emit(IdeasVoteSuccess(ideas));
    }else {

      emit(IdeasVoteFailure(List.from(state.ideas), "Nepodařilo se zahlasovat!"));
    }
  }

  void _onIdeasCreated(IdeasCreated event, Emitter<IdeasState> emit) async {
    final IdeaCreateModel ideaCreateModel = IdeaCreateModel(
      title: event.title,
      description: event.description,
      deadline: event.deadline,
      userId: event.user.id,
    );

    final DataState<IdeaModel> dataState = await createIdeaUseCase(params: ideaCreateModel);

    if(dataState is DataSuccess){
      List<IdeaModel> ideas = List.from(state.ideas);
      ideas.add(dataState.data!);

      emit(IdeasCreateSuccess(ideas));
    }else{
      emit(IdeasCreateFailure(List.from(state.ideas), "Nepodařilo se vytvořit nápad!"));
    }
  }

  void _onIdeasDeleted(IdeasDeleted event, Emitter<IdeasState> emit) async {

    final DataState<IdeaModel> dataState = await deleteIdeaUseCase(params: event.idea.id);

    if(dataState is DataSuccess){
      List<IdeaModel> ideas = List.from(state.ideas);
      ideas.remove(event.idea);

      emit(IdeasDeleteSuccess(ideas));
    }else{
      emit(IdeasDeleteFailure(List.from(state.ideas), "Nepodařilo se smazat nápad!"));

    }

  }

}