import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/domain/entites/song.dart';

abstract class SongRepository {

  Future<DataState<List<SongEntity>>> getSongs();

  Future<DataState<SongEntity>> getSong(int id);

  Future<DataState<SongEntity>> createSong(SongCreateModel song);

  Future<DataState<SongEntity>> uploadSong(SongEntity song, File file);

  Future<DataState<SongEntity>> uploadVideo(SongEntity song, File file);

}