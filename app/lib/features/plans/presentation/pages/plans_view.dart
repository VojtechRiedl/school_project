import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_bloc.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_event.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_state.dart';
import 'package:band_app/features/plans/presentation/widgets/plan_widget.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PlansView extends StatefulWidget {
  const PlansView({Key? key}) : super(key: key);

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> {

  @override
  void initState() {
    context.read<PlansBloc>().add(const PlansFetched());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlansBloc, PlansState>(
      builder: (BuildContext context, PlansState state) {
        if(state is PlansInitial){
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: state.plans.length,
                  itemBuilder: (context, index) {
                    return PlanWidget(plans: state.plans.values.elementAt(index), date: state.plans.keys.elementAt(index));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (){
                    GoRouter.of(context).pushNamed("plan-create");
                  },
                  child: const Icon(Icons.add, size: 32,)
              )
            ],
          ),
        );

      },
      listener: (BuildContext context, PlansState state) {},
    );
  }
}