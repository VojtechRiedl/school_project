import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/domain/repository/plan_repository.dart';

class DeletePlanUseCase extends UseCase<DataState<PlanModel>,int>{

  final PlanRepository repository;

  DeletePlanUseCase(this.repository);

  @override
  Future<DataState<PlanModel>> call({int ? params}) {
    return repository.deletePlan(params!) as Future<DataState<PlanModel>>;
  }

}