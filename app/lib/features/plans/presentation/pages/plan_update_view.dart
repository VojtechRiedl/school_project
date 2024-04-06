import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/ideas/presentation/widgets/date_input.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_bloc.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_event.dart';
import 'package:band_app/features/plans/presentation/bloc/validation/validation_cubit.dart';
import 'package:band_app/features/plans/presentation/bloc/validation/validation_state.dart';
import 'package:band_app/features/plans/presentation/widgets/plan_input.dart';
import 'package:band_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PlanUpdateView extends StatefulWidget {

  const PlanUpdateView({Key? key}) : super(key: key);

  @override
  State<PlanUpdateView> createState() => _PlanUpdateViewState();
}

class _PlanUpdateViewState extends State<PlanUpdateView> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;

  @override
  void initState() {

    PlansBloc plansBloc = context.read<PlansBloc>();
    titleController = TextEditingController()..text = plansBloc.state.plan!.title;
    descriptionController = TextEditingController()..text = plansBloc.state.plan!.description ?? '';
    dateController = TextEditingController()..text = DateFormat("yyyy-MM-dd").format(plansBloc.state.plan!.date);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidationCubit>(
      create: (context) => sl<ValidationCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MainAppBar(

          title: Text('Nápady'),
        ),
        body:_buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    return BlocConsumer<ValidationCubit,ValidationState>(
      builder: (BuildContext context, ValidationState state) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PlanInput(
                      multiLine: false,
                      label: 'Název',
                      controller: titleController,
                    ),
                    PlanInput(
                      multiLine: true,
                      label: 'Popis',
                      controller: descriptionController,
                    ),
                    DateInput(
                      label: 'Datum',
                      controller: dateController,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    context.read<ValidationCubit>().updateValidate(titleController.text, descriptionController.text, DateTime.parse(dateController.text));
                  },
                  child: const Text('Upravit', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            )
        );
      },
      listener: (BuildContext context, ValidationState state) {
        if (state is ValidationSuccess){
          context.read<PlansBloc>().add(PlanUpdated(state.title, state.description, state.deadline));
          context.pop(context);
        }else if (state is ValidationFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.message),
            ),
          );
        }
      },
    );
  }
}