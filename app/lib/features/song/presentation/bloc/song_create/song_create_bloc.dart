import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/usecases/create_song.dart';
import 'package:band_app/features/song/domain/usecases/upload_sound.dart';
import 'package:band_app/features/song/domain/usecases/upload_video.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_event.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_state.dart';
import 'package:band_app/features/user/domain/usecases/get_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongCreateBloc extends Bloc<SongCreateEvent, SongCreateState>{
  final UploadSoundUseCase _uploadSoundUseCase;
  final UploadVideoUseCase _uploadVideoUseCase;
  final GetUserUseCase _getUserUseCase;
  final CreateSongUseCase _createSongUseCase;


  SongCreateBloc(this._uploadSoundUseCase, this._uploadVideoUseCase, this._getUserUseCase, this._createSongUseCase) : super(SongCreateInitial()){
    on<CreateSong>(_onSongCreate);
    on<LoadSound>(_onSoundLoad);
    on<LoadVideo>(_onVideoLoad);
  }

  void _onSongCreate(CreateSong event, Emitter<SongCreateState> emit) async {
    if(event.title.isEmpty){
      emit(TitleError("Název písničky nesmí být prázdný", state.songFileResult, state.videoFileResult));
      return;
    }
    final user = await _getUserUseCase();

    final newSong = SongCreateModel(
      title: event.title,
      youtubeLink: event.youtubeLink,
      text: event.text,
      user: user.id,
    );

    final dataState = await _createSongUseCase(params: newSong);

    if(dataState is DataSuccess) {

      SongEntity song = dataState.data!;


      if (state.videoFileResult != null) {
        File videoFile = File(state.videoFileResult!.files.single.path!);

        final videoDataState = await _uploadVideoUseCase(
            params: song, file: videoFile);

        if (videoDataState is DataFailed) {

          print(videoDataState.error);

          await Future.delayed(const Duration(seconds: 1));

          emit(UploadError("Nepovedlo se nahrát video", state.songFileResult, state.videoFileResult));
        }
      }
      if (state.songFileResult != null) {
        File songFile = File(state.songFileResult!.files.single.path!);

        final soundDataState = await _uploadSoundUseCase(
            params: song, file: songFile);

        if (soundDataState is DataFailed) {

          await Future.delayed(const Duration(seconds: 1));
          emit(UploadError("Nepovedla se nahrát písnička", state.songFileResult, state.videoFileResult));
        }
      }
      emit(SongCreated(song, state.songFileResult, state.videoFileResult));
    }else {
      emit(SongCreateError("Nepovedlo se vytvořit písničku", state.songFileResult, state.videoFileResult));
    }
  }

  void _onSoundLoad(LoadSound event, Emitter<SongCreateState> emit) async {
    emit(SoundLoaded(event.file, state.videoFileResult));
  }

  void _onVideoLoad(LoadVideo event, Emitter<SongCreateState> emit) async {
    emit(VideoLoaded(state.songFileResult, event.file));
  }
}