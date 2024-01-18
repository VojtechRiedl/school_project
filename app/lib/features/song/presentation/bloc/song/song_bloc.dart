import 'package:band_app/core/constants/environment.dart';
import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/usecases/delete_song.dart';
import 'package:band_app/features/song/domain/usecases/get_song.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongBloc extends Bloc<SongEvent, SongState>{
  final GetSongUseCase _getSongUseCase;
  final DeleteSongUseCase _deleteSongUseCase;

  SongBloc(this._getSongUseCase, this._deleteSongUseCase) : super(const SongInitial()) {
    on<LoadSong>(_onSongLoad);
    on<DeleteSong>(_onSongDelete);
  }

  void _onSongLoad(LoadSong event, Emitter<SongState> emit) async {
    final songDataState = await _getSongUseCase(params: event.id);

    if(songDataState is DataSuccess) {

      SongEntity songEntity = songDataState.data!;

      emit(SongLoaded(songEntity));
    }else{
      //TOOD: Error handling
      emit(const SongInitial());
    }

  }

  void _onSongDelete(DeleteSong event, Emitter<SongState> emit) async {
    final dataState = await _deleteSongUseCase(params: event.id);

    if(dataState is DataSuccess) {
      emit(SongDeleted(dataState.data!));

    }else{
      emit(const SongInitial());
    }

  }

}