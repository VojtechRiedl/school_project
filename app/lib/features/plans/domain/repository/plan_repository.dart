import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/features/plans/data/models/plan_create.dart';
import 'package:band_app/features/plans/data/models/plan_update.dart';
import 'package:band_app/features/plans/domain/entities/plan.dart';

abstract class PlanRepository {
  Future<DataState<List<PlanEntity>>> getPlans();
  Future<DataState<PlanEntity>> getPlanById(int id);
  Future<DataState<PlanEntity>> createPlan(PlanCreateModel planCreateModel);
  Future<DataState<PlanEntity>> updatePlan(int id, PlanUpdateModel planUpdateModel);
  Future<DataState<PlanEntity>> deletePlan(int id);
}
