import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/usecases/create_song.dart';
import 'package:band_app/features/song/domain/usecases/get_songs.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_state.dart';
import 'package:band_app/features/user/domain/usecases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState>{
  final GetSongsUseCase _getSongsUseCase;
  final CreateSongUseCase _createSongUseCase;
  final GetUserUseCase _getUserUseCase;


  SongsBloc(this._getSongsUseCase, this._getUserUseCase, this._createSongUseCase) : super(SongsInitial()){
    on<LoadSongs>(_onSongsLoading);
    on<SearchSongs>(_onSongSearch);
    on<CreateSong>(_onSongCreate);

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

  void _onSongCreate(CreateSong event, Emitter<SongsState> emit) async {
    final user = await _getUserUseCase();

    final newSong = SongCreateModel(
      title: event.title,
      youtubeLink: event.youtubeLink,
      text: event.text,
      user: user.id,
    );

    final dataState = await _createSongUseCase(params: newSong);

    if(dataState is DataSuccess){
      List<SongEntity> songs = List.from(state.songs)..add(dataState.data!);

      print("added");
      //emit(SongsLoaded(state.songs));
      emit(SongCreated(songs));
    }else{
      print("error");
      //TODO handle error
      emit(SongCreated(state.songs));

    }


  }
}