import 'package:band_app/features/user/data/models/user.dart';
import 'package:band_app/features/user/data/models/user_update.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET("/users/")
  Future<HttpResponse<List<UserModel>>> getUsers();
  
  @GET("/users/{id}")
  Future<HttpResponse<UserModel>> getUser({
    @Path("id") required int id,
  });

  @PATCH("/users/update/{id}")
  Future<HttpResponse<UserModel>> updateUser({
    @Path("id") required int id,
    @Body() required UserUpdateModel userUpdate,
  });


}