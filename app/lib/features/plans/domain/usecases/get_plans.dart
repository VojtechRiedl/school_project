import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/usecase.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/domain/repository/plan_repository.dart';

class GetPlansUseCase extends UseCase<DataState<List<PlanModel>>,void>{

  final PlanRepository repository;

  GetPlansUseCase(this.repository);

  @override
  Future<DataState<List<PlanModel>>> call({void params}) {
    return repository.getPlans() as Future<DataState<List<PlanModel>>>;
  }

}