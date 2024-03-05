import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/ideas/data/data_sources/remote/idea_api_service.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/data/models/idea_create.dart';
import 'package:band_app/features/ideas/data/models/vote_create.dart';
import 'package:band_app/features/ideas/domain/repository/idea_repository.dart';
import 'package:dio/dio.dart';

class IdeaRepositoryImpl extends IdeaRepository{
  final IdeaApiService _ideaApiService;

  IdeaRepositoryImpl(this._ideaApiService);

  @override
  Future<DataState<IdeaModel>> createIdea(IdeaCreateModel ideaCreate) async {
    try{
      final response = await _ideaApiService.createIdea(ideaCreate: ideaCreate);

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
  Future<DataState<IdeaModel>> createVote(VoteCreateModel voteCreate) async {
    try{
      final response = await _ideaApiService.createVote(voteCreate: voteCreate);

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
  Future<DataState<IdeaModel>> deleteIdea(int id) async {
    try{
      final response = await _ideaApiService.deleteIdea(id: id);

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
  Future<DataState<List<IdeaModel>>> getIdeas() async {
    try{
      final response = await _ideaApiService.getIdeas();

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