import 'package:band_app/features/login/data/models/Authorization.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'authorization_api_service.g.dart';

@RestApi()
abstract class AuthorizationApiService {
  factory AuthorizationApiService(Dio dio, {String baseUrl}) = _AuthorizationApiService;

  @POST("/authorization/login")
  Future<HttpResponse<UserModel>> login({
    @Body() required AuthorizationModel authorization,
  });


  @POST("/authorization/register")
  Future<HttpResponse<UserModel>> register({
    @Body() required AuthorizationModel authorization,
  });
  


}