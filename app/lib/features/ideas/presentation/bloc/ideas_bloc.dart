import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/domain/usecases/get_ideas.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas_event.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeasBloc extends Bloc<IdeasEvent, IdeasState>{
  final GetIdeasUseCase getIdeasUseCase;

  IdeasBloc(this.getIdeasUseCase) : super(IdeasLoadInProgress()) {
    on<IdeasLoaded>(_onIdeasLoad);
  }

  void _onIdeasLoad(IdeasLoaded event, Emitter<IdeasState> emit) async {

    final DataState<List<IdeaModel>> dataState = await getIdeasUseCase();

    if(dataState is DataSuccess) {
      emit(IdeasLoadSuccess(dataState.data!));
    }else{
      emit(const IdeasLoadFailure());
    }

  }


}