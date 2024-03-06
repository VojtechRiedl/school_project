import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/ideas/presentation/bloc/idea_validation/idea_validation_cubit.dart';
import 'package:band_app/features/ideas/presentation/bloc/idea_validation/idea_validation_state.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_bloc.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_event.dart';
import 'package:band_app/features/ideas/presentation/widgets/date_input.dart';
import 'package:band_app/features/ideas/presentation/widgets/idea_input.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateIdeaView extends StatefulWidget {
  const CreateIdeaView({Key? key}) : super(key: key);

  @override
  State<CreateIdeaView> createState() => _CreateIdeaViewState();
}

class _CreateIdeaViewState extends State<CreateIdeaView> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController deadlineController;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    deadlineController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IdeaValidationCubit>(
      create: (context) => sl<IdeaValidationCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.light,
        appBar: const MainAppBar(

          title: Text('Nápady'),
        ),
        body:_buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    return BlocConsumer<IdeaValidationCubit,IdeaValidationState>(
      builder: (BuildContext context, IdeaValidationState state) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IdeaInput(
                      multiLine: false,
                      label: 'Název',
                      controller: titleController,
                    ),
                    IdeaInput(
                      multiLine: true,
                      label: 'Popis',
                      controller: descriptionController,
                    ),
                    DateInput(
                      label: 'Datum',
                      controller: deadlineController,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Palette.dark),
                    fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 40, 50)),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)
                            ))),
                  ),
                  onPressed: (){
                    context.read<IdeaValidationCubit>().validate(titleController.text, descriptionController.text, DateTime.parse(deadlineController.text));
                  },
                  child: const Text('Přidat', style: TextStyle(color: Palette.yellow, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            )
        );
      },
      listener: (BuildContext context, IdeaValidationState state) {
        if (state is IdeaValidationSuccess){
          AuthorizationBloc bloc = context.read<AuthorizationBloc>();

          if(bloc.state is! AuthorizationAuthenticateSuccess){
            return;
          }
          context.read<IdeasBloc>().add(IdeasCreated(state.title, state.description, state.deadline, (bloc.state as AuthorizationAuthenticateSuccess).user));
          context.pop(context);
        }else if (state is IdeaValidationFailure){
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