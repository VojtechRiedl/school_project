import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_bloc.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_event.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_state.dart';
import 'package:band_app/features/plans/presentation/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PlanView extends StatefulWidget {

  final int id;
  const PlanView({Key? key, required this.id}) : super(key: key);

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  
  @override
  void initState() {
    context.read<PlansBloc>().add(PlanFetched(widget.id));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('Plán'),
      ),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PlansBloc, PlansState>(
      builder: (BuildContext context, state) {
        if(state is PlanUpdateSuccess || state is PlanLoadSuccess || state is PlanCreateSuccess){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.plan!.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        Text(DateFormat("dd.MM.yyyy").format(state.plan!.date), style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(state.plan!.description ?? "", style: Theme.of(context).textTheme.bodyMedium),
                        Divider(color: Theme.of(context).colorScheme.onSurface, height: 20, thickness: 1),
                        Text(state.plan!.user.username, textAlign: TextAlign.end,)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Theme.of(context).colorScheme.onSurface
                      ),
                        onPressed: (){
                          GoRouter.of(context).pushNamed("plan-update", pathParameters: {"id": widget.id.toString()});
                        },
                        child: const Icon(Icons.edit, size: 32,)
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () async {
                          showDeletePlanDialog(context).then((value) {
                            if(value){
                              context.read<PlansBloc>().add(PlanDeleted(widget.id));
                            }
                          });
                        },
                        child: const Text("Smazat")
                    )
                  ],
                )
              ],
            ),
          );
        }

        return const Center(
          child: Text("Error"),
        );
      }, listener: (BuildContext context, PlansState state) {
        if(state is PlanDeleteSuccess){
          GoRouter.of(context).pop(context);
        }
    },
    );
  }
}