import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/song/data/data_sources/remote/song_api_service.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/data/models/song_update.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/domain/repository/song_repository.dart';
import 'package:dio/dio.dart';

class SongRepositoryImpl extends SongRepository{

  final SongApiService _songApiService;

  SongRepositoryImpl(this._songApiService);

  @override
  Future<DataState<SongEntity>> getSong(int id) async {
    try{
      final response = await _songApiService.getSongById(id: id);

      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }

    }on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<SongEntity>>> getSongs() async {

    try{
      final response = await _songApiService.getSongs();

      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }

    }on DioException catch(e){
      return DataFailed(e);
    }

  }

  @override
  Future<DataState<SongEntity>> createSong(SongCreateModel song) async {
    try{
      final response = await _songApiService.createSong(song: song);

      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }

    }on DioException catch(e){
      return DataFailed(e);
    }


  }

  @override
  Future<DataState<SongEntity>> uploadSong(SongEntity song, File file) async {
    try{

      final response = await _songApiService.uploadSound(id: song.id, file: file);
      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SongEntity>> uploadVideo(SongEntity song, File file) async {
    try{
      final response = await _songApiService.uploadVideo(id: song.id, file: file);
      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SongEntity>> deleteSong(int id) async {
    try{
      final response = await _songApiService.deleteSong(id: id);

      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SongEntity>> updateSong(int id,SongUpdateModel song) async {
    try{
      final response = await _songApiService.updateSong(id: id, song: song);

      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      }else{
        return DataFailed(
          DioException(
            error: response.response.statusMessage,
            requestOptions: response.response.requestOptions,
            response: response.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }

    }on DioException catch(e){
      return DataFailed(e);
    }

  }

}