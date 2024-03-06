import 'dart:io';

import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/data/models/idea_create.dart';
import 'package:band_app/features/ideas/data/models/vote_create.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'idea_api_service.g.dart';

@RestApi()
abstract class IdeaApiService {
  factory IdeaApiService(Dio dio, {String baseUrl}) = _IdeaApiService;

  @GET("/ideas/")
  Future<HttpResponse<List<IdeaModel>>> getIdeas();

  @POST("/ideas/create")
  Future<HttpResponse<IdeaModel>> createIdea({
    @Body() required IdeaCreateModel ideaCreate,
  });

  @PUT("/ideas/vote")
  Future<HttpResponse<IdeaModel>> createVote({
    @Body() required VoteCreateModel voteCreate,
  });

  @DELETE("/ideas/delete/{id}")
  Future<HttpResponse<IdeaModel>> deleteIdea({
    @Path("id") required int id,
  });

}