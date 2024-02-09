import 'dart:io';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/login/data/data_sources/remote/authorization_api_service.dart';
import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/login/domain/repository/authorization_repository.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:dio/dio.dart';

class AuthorizationRepositoryImpl implements AuthorizationRepository {
  final AuthorizationApiService apiService;

  AuthorizationRepositoryImpl({required this.apiService});

  @override
  Future<DataState<UserModel>> login(AuthorizationModel authorization) async {
    try {
      final httpResponse = await apiService.login(authorization: authorization);
      print(httpResponse);

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> register(AuthorizationModel authorization) async {
    try{
      final response = await apiService.register(authorization: authorization);
      print(response);
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