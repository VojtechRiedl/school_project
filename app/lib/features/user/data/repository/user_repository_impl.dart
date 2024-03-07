import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/user/data/data_sources/remote/user_api_service.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/data/models/user_update.dart';
import 'package:band_app/features/user/domain/repository/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository{
  final  UserApiService _userApiService;

  UserRepositoryImpl(this._userApiService);


  @override
  Future<DataState<UserModel>> getUser(int id) async {
    try{
      final response = await _userApiService.getUser(id: id);

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
  Future<DataState<List<UserModel>>> getUsers() async {
    try{
      final response = await _userApiService.getUsers();

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
  Future<DataState<UserModel>> updateUser(int id, UserUpdateModel userUpdate) async {
    try{
      final response = await _userApiService.updateUser(id: id, userUpdate: userUpdate);

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