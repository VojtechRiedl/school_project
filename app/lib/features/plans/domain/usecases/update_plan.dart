import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/params.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/domain/repository/plan_repository.dart';

class UpdatePlanUseCase extends UseCase<DataState<PlanModel>,UpdatePlanParams>{

  final PlanRepository repository;

  UpdatePlanUseCase(this.repository);

  @override
  Future<DataState<PlanModel>> call({UpdatePlanParams ? params}) {
    return repository.updatePlan(params!.id, params.planUpdate) as Future<DataState<PlanModel>>;
  }

}