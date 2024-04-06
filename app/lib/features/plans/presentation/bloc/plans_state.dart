import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:equatable/equatable.dart';

abstract class PlansState extends Equatable {
  final Map<DateTime, List<PlanModel>> plans;
  final PlanModel ? plan;

  const PlansState({this.plans = const {}, this.plan});

  @override
  List<Object?> get props => [plans];
}

class PlansInitial extends PlansState {

  @override
  List<Object> get props => [];
}

class PlansLoadSuccess extends PlansState {

  const PlansLoadSuccess(Map<DateTime, List<PlanModel>> plans) : super(plans: plans);

}

class PlanLoadSuccess extends PlansState {

  const PlanLoadSuccess(PlanModel plan, Map<DateTime, List<PlanModel>> plans) : super(plan: plan, plans: plans);

  @override
  List<Object?> get props => [plan, plans];
}

class PlanUpdateSuccess extends PlansState {

  const PlanUpdateSuccess(PlanModel plan, Map<DateTime, List<PlanModel>> plans) : super(plan: plan, plans: plans);

  @override
  List<Object?> get props => [plan, plans];
}

class PlanDeleteSuccess extends PlansState {

  const PlanDeleteSuccess(Map<DateTime, List<PlanModel>> plans) : super(plans: plans);

  @override
  List<Object?> get props => [plans];

}

class PlanCreateSuccess extends PlansState {

  const PlanCreateSuccess(Map<DateTime, List<PlanModel>> plans) : super(plans: plans);

  @override
  List<Object?> get props => [plans];
}