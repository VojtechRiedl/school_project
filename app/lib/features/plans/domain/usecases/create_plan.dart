import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/data/models/plan_create.dart';
import 'package:band_app/features/plans/domain/repository/plan_repository.dart';

class CreatePlanUseCase extends UseCase<DataState<PlanModel>,PlanCreateModel>{

  final PlanRepository repository;

  CreatePlanUseCase(this.repository);

  @override
  Future<DataState<PlanModel>> call({PlanCreateModel ? params}) {
    return repository.createPlan(params!) as Future<DataState<PlanModel>>;
  }

}