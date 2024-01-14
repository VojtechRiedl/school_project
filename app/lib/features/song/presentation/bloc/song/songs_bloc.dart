import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/usecases/create_song.dart';
import 'package:band_app/features/song/domain/usecases/get_songs.dart';
import 'package:band_app/features/song/domain/usecases/upload_sound.dart';
import 'package:band_app/features/song/domain/usecases/upload_video.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_state.dart';
import 'package:band_app/features/user/domain/usecases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState>{
  final GetSongsUseCase _getSongsUseCase;

  SongsBloc(this._getSongsUseCase) : super(SongsInitial()){
    on<LoadSongs>(_onSongsLoading);
    on<SearchSongs>(_onSongSearch);
    on<AddSong>(_onSongCreate);

  }

  void _onSongsLoading(LoadSongs event, Emitter<SongsState> emit) async {
    print("loaded");
    final dataState = await _getSongsUseCase();

    if(dataState is DataSuccess){
      emit(SongsLoaded(dataState.data));
    }else if(dataState is DataFailed){
      //TODO handle error
      emit(const SongsLoaded(<SongEntity>[]));
    }
  }

  void _onSongSearch(SearchSongs event, Emitter<SongsState> emit) {

    final suggestions = event.suggestions.where((element) => element.title.toLowerCase().contains(event.query.toLowerCase())).toList();

    emit(SongsSearched(event.query, suggestions, event.suggestions));
  }

  void _onSongCreate(AddSong event, Emitter<SongsState> emit) async {
    List<SongEntity> songs = List.from(state.songs)..add(event.song);

    emit(SongCreated(songs));
  }
}