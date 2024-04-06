import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/plans/data/data_sources/remote/plans_api_service.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/data/models/plan_create.dart';
import 'package:band_app/features/plans/data/models/plan_update.dart';
import 'package:band_app/features/plans/domain/entities/plan.dart';
import 'package:band_app/features/plans/domain/repository/plan_repository.dart';
import 'package:dio/dio.dart';

class PlanRepositoryImpl extends PlanRepository{

  final PlansApiService _plansApiService;

  PlanRepositoryImpl(this._plansApiService);


  @override
  Future<DataState<PlanModel>> createPlan(PlanCreateModel planCreateModel) async {
    try{
      final response = await _plansApiService.createPlan(planCreateModel: planCreateModel);

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
  Future<DataState<PlanModel>> deletePlan(int id) async {
    try{
      final response = await _plansApiService.deletePlan(id: id);

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
  Future<DataState<PlanModel>> getPlanById(int id) async{
    try{
      final response = await _plansApiService.getPlanById(id: id);

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
  Future<DataState<List<PlanModel>>> getPlans() async {
    try{
      final response = await _plansApiService.getPlans();

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
  Future<DataState<PlanModel>> updatePlan(int id, PlanUpdateModel planUpdateModel) async {
    try{
      final response = await _plansApiService.updatePlan(id: id, planUpdateModel: planUpdateModel);

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