import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';

class UploadSoundUseCase extends UseCase<DataState<SongEntity>, SongEntity> {
  final SongRepository _songRepository;

  UploadSoundUseCase(this._songRepository);

  @override
  Future<DataState<SongEntity>> call({SongEntity? params, File ? file}) {
    return _songRepository.uploadSong(params!, file!);
  }
}