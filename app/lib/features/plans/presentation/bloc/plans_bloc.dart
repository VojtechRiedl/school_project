import 'dart:async';

import 'package:band_app/core/resources/data_state.dart';
import 'package:band_app/core/usecases/params.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/data/models/plan_create.dart';
import 'package:band_app/features/plans/data/models/plan_update.dart';
import 'package:band_app/features/plans/domain/usecases/create_plan.dart';
import 'package:band_app/features/plans/domain/usecases/delete_plan.dart';
import 'package:band_app/features/plans/domain/usecases/get_plan.dart';
import 'package:band_app/features/plans/domain/usecases/get_plans.dart';
import 'package:band_app/features/plans/domain/usecases/update_plan.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_event.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {

  final CreatePlanUseCase createPlanUseCase;
  final DeletePlanUseCase deletePlanUseCase;
  final GetPlansUseCase getPlansUseCase;
  final GetPlanUseCase getPlanUseCase;
  final UpdatePlanUseCase updatePlanUseCase;
  
  
  PlansBloc(this.createPlanUseCase, this.deletePlanUseCase, this.getPlansUseCase, this.getPlanUseCase, this.updatePlanUseCase) : super(PlansInitial()){
    on<PlanCreated>(_onPlanCreate);
    on<PlanDeleted>(_onPlanDelete);
    on<PlansFetched>(_onPlansFetch);
    on<PlanFetched>(_onPlanFetch);
    on<PlanUpdated>(_onPlanUpdate);
  }


  void _onPlanCreate(PlanCreated event, Emitter<PlansState> emit) async {

    PlanCreateModel planCreateModel = PlanCreateModel(
        title: event.title,
        description: event.description,
        date: event.date,
        userId: event.userId
    );

    final dataState = await createPlanUseCase(params: planCreateModel);

    if(dataState is DataSuccess){

      Map<DateTime, List<PlanModel>> plans = state.plans;
      PlanModel plan = dataState.data!;

      DateTime date = plan.date.copyWith(
        minute: 0,
        hour: 0,
        second: 0,
        microsecond: 0,
        millisecond: 0,
      );
      if(plans.containsKey(date)){
        plans[date]!.add(plan);
      }else{
        plans[date] = [plan];
      }

      emit(PlanCreateSuccess(plans));
    }else{
      //TODO: Handle error
      /*emit(PlansError(dataState.error));*/
    }

  }

  void _onPlanDelete(PlanDeleted event, Emitter<PlansState> emit) async {

    final dataState = await deletePlanUseCase(params: event.id);

    if(dataState is DataSuccess) {

      Map<DateTime, List<PlanModel>> plans = state.plans;

      for (var date in plans.keys.toList()) {
        plans[date]!.removeWhere((element) => element.id == event.id);
        if (plans[date]!.isEmpty) {
          plans.remove(date);
        }
      }
      emit(PlanDeleteSuccess(plans));

    }else{

    }
  }

  void _onPlansFetch(PlansFetched event, Emitter<PlansState> emit) async {

    final dataState = await getPlansUseCase();

    if(dataState is DataSuccess){
      Map<DateTime, List<PlanModel>> plans = {};

      for (var plan in dataState.data!) {
        DateTime date = plan.date.copyWith(
          minute: 0,
          hour: 0,
          second: 0,
          microsecond: 0,
          millisecond: 0,
        );
        if(plans.containsKey(date)){
          plans[date]!.add(plan);
        }else{
          plans[date] = [plan];
        }
      }
      emit(PlansLoadSuccess(plans));
    }else{
      //TODO: Handle error
      /*emit(PlansError(dataState.error));*/
    }


  }

  void _onPlanUpdate(PlanUpdated event, Emitter<PlansState> emit) async {

    UpdatePlanParams params = UpdatePlanParams(
      id: state.plan!.id,
      planUpdate: PlanUpdateModel(
          title: event.title,
          description: event.description,
          date: event.date
      ),
    );

    final dataState = await updatePlanUseCase(params: params);

    if(dataState is DataSuccess){

      Map<DateTime, List<PlanModel>> plans = state.plans;

      for (var date in plans.keys.toList()) {

        plans[date]!.removeWhere((element) => element.id == state.plan!.id);
        plans[date]!.add(dataState.data!);
      }

      emit(PlanUpdateSuccess(dataState.data!, plans));
    }else{

    }

  }

  void _onPlanFetch(PlanFetched event, Emitter<PlansState> emit) async {

    final dataState = await getPlanUseCase(params: event.id);

    if(dataState is DataSuccess){
      emit(PlanLoadSuccess(dataState.data!, state.plans));
    }else{

    }

  }
}