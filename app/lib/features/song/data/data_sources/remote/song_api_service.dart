import 'dart:io';

import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/data/models/song_create.dart';
import 'package:band_app/features/song/data/models/song_update.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'song_api_service.g.dart';

@RestApi()
abstract class SongApiService {
  factory SongApiService(Dio dio, {String baseUrl}) = _SongApiService;

  @GET("/songs/")
  Future<HttpResponse<List<SongModel>>> getSongs();

  @GET("/songs/{id}")
  Future<HttpResponse<SongModel>> getSongById({
    @Path("id") required int id,
  });

  @POST("/songs/create")
  Future<HttpResponse<SongModel>> createSong({
    @Body() required SongCreateModel song,
  });

  @POST("/songs/video/upload/{id}")
  @MultiPart()
  Future<HttpResponse<SongModel>> uploadVideo({
    @Path('id') required int id,
    @Part(name: "video_file") required File file,
  });

  @POST("/songs/sound/upload/{id}")
  @MultiPart()
  Future<HttpResponse<SongModel>> uploadSound({
    @Path('id') required int id,
    @Part(name: "sound_file") required File file,
  });

  @DELETE("/songs/delete/{id}")
  Future<HttpResponse<SongModel>> deleteSong({
    @Path("id") required int id,
  });

  @PATCH("/songs/update/{id}")
  Future<HttpResponse<SongModel>> updateSong({
    @Path("id") required int id,
    @Body() required SongUpdateModel song,
  });
}