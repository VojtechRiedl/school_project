import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';

class UploadVideoUseCase extends UseCase<DataState<SongModel>, SongEntity> {
  final SongRepository _songRepository;

  UploadVideoUseCase(this._songRepository);

  @override
  Future<DataState<SongModel>> call({SongEntity? params, File ? file}) {
    return _songRepository.uploadVideo(params!, file!) as Future<DataState<SongModel>>;
  }
}