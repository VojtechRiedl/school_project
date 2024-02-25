import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/params.dart';
import 'package:band_app/features/song/data/models/song_update.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/usecases/get_song.dart';
import 'package:band_app/features/song/domain/usecases/update_song.dart';
import 'package:band_app/features/song/domain/usecases/upload_sound.dart';
import 'package:band_app/features/song/domain/usecases/upload_video.dart';
import 'package:band_app/features/song/presentation/bloc/song_update/song_update_event.dart';
import 'package:band_app/features/song/presentation/bloc/song_update/song_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongUpdateBloc extends Bloc<SongUpdateEvent, SongUpdateState> {
  final UploadSoundUseCase _uploadSoundUseCase;
  final UploadVideoUseCase _uploadVideoUseCase;
  final GetSongUseCase _getSongUseCase;
  final UpdateSongUseCase _updateSongUseCase;


  SongUpdateBloc(this._uploadSoundUseCase, this._uploadVideoUseCase,
      this._getSongUseCase, this._updateSongUseCase)
      : super(SongUpdateInitial()) {
    on<LoadSong> (_onLoadSong);
    on<UpdateSong>(_onSongUpdate);
    on<LoadSound>(_onSoundLoad);
    on<LoadVideo>(_onVideoLoad);
  }

  void _onLoadSong(LoadSong event, Emitter<SongUpdateState> emit) async {
    final dataState = await _getSongUseCase(params: event.id);

    if (dataState is DataSuccess) {
      emit(SongLoaded(dataState.data!));
    } else {
      emit(const SongUpdateError("Nepovedlo se načíst písničku", null, null));
    }
  }


  void _onSongUpdate(UpdateSong event, Emitter<SongUpdateState> emit) async {
    if (event.title.isEmpty) {
      emit(TitleError("Název písničky nesmí být prázdný", state.songFileResult,
          state.videoFileResult));
      return;
    }

    final updatedSong = SongUpdateModel(
      title: event.title,
      youtubeLink: event.youtubeLink,
      text: event.text,
    );

    final UpdateSongParams params = UpdateSongParams(id: event.id, song: updatedSong);

    final dataState = await _updateSongUseCase(params: params);

    if (dataState is DataSuccess) {
      SongEntity song = dataState.data!;


      if (state.videoFileResult != null) {
        File videoFile = File(state.videoFileResult!.files.single.path!);

        final videoDataState = await _uploadVideoUseCase(
            params: song, file: videoFile);

        if (videoDataState is DataFailed) {
          print(videoDataState.error);

          await Future.delayed(const Duration(seconds: 1));

          emit(UploadError("Nepovedlo se nahrát video", state.songFileResult,
              state.videoFileResult));
        }
      }
      if (state.songFileResult != null) {
        File songFile = File(state.songFileResult!.files.single.path!);

        final soundDataState = await _uploadSoundUseCase(
            params: song, file: songFile);

        if (soundDataState is DataFailed) {
          await Future.delayed(const Duration(seconds: 1));
          emit(UploadError("Nepovedla se nahrát písnička", state.songFileResult,
              state.videoFileResult));
        }
      }
      emit(SongUpdated(song, state.songFileResult, state.videoFileResult));
    } else {
      emit(SongUpdateError(
          "Nepovedlo se vytvořit písničku", state.songFileResult,
          state.videoFileResult));
    }
  }

  void _onSoundLoad(LoadSound event, Emitter<SongUpdateState> emit) async {
    emit(SoundLoaded(event.file, state.videoFileResult));
  }

  void _onVideoLoad(LoadVideo event, Emitter<SongUpdateState> emit) async {
    emit(VideoLoaded(state.songFileResult, event.file));
  }
}