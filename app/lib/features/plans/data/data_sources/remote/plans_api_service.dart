import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/data/models/plan_create.dart';
import 'package:band_app/features/plans/data/models/plan_update.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'plans_api_service.g.dart';

@RestApi()
abstract class PlansApiService {
  factory PlansApiService(Dio dio, {String baseUrl}) = _PlansApiService;

  @GET("/plans/")
  Future<HttpResponse<List<PlanModel>>> getPlans();

  @GET("/plans/{id}")
  Future<HttpResponse<PlanModel>> getPlanById({
    @Path("id") required int id,
  });
  
  @POST("/plans/create")
  Future<HttpResponse<PlanModel>> createPlan({
    @Body() required PlanCreateModel planCreateModel,
  });


  @PATCH("/plans/update/{id}")
  Future<HttpResponse<PlanModel>> updatePlan({
    @Path("id") required int id,
    @Body() required PlanUpdateModel planUpdateModel,
  });

  @DELETE("/plans/delete/{id}")
  Future<HttpResponse<PlanModel>> deletePlan({
    @Path("id") required int id,
  });



}