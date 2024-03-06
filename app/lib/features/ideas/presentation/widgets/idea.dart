import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_bloc.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_event.dart';
import 'package:band_app/features/ideas/presentation/widgets/dialog.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class IdeaWidget extends StatelessWidget {
  final IdeaModel idea;
  const IdeaWidget({
    Key? key,
    required this.idea,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AuthorizationBloc bloc = context.read<AuthorizationBloc>();

    if(bloc.state is! AuthorizationAuthenticateSuccess){
      return const SizedBox();
    }

    bool ? accepted = idea.votes.where((element) => element.author.id == (bloc.state as AuthorizationAuthenticateSuccess).user.id).firstOrNull?.accepted;

    return GestureDetector(
      onLongPress: () async {
        final bool deleted = await showDeleteIdeaDialog(context);
        if (deleted){
          if(!context.mounted){
            return;
          }
          context.read<IdeasBloc>().add(IdeasDeleted(idea));
        }
      },
      child: Card(
        color: Palette.secondLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(idea.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text(DateFormat("yyyy-MM-dd").format(idea.deadline).toString(), style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const Divider(
              height: 0,
              color: Palette.dark,
              thickness: 1,

            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(idea.description, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("${idea.author.username} ${DateFormat("yyyy-MM-dd").format(idea.created)}", style: const TextStyle(fontSize: 12)),
            ),
            const Divider(
              height: 0,
              color: Palette.dark,
              thickness: 1,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Palette.accept,
                  onPressed: (){
                    AuthorizationBloc bloc = context.read<AuthorizationBloc>();

                    if(bloc.state is! AuthorizationAuthenticateSuccess){
                      return;
                    }

                    if(accepted == null || accepted == false){
                      context.read<IdeasBloc>().add(IdeasVoted(true, idea, (bloc.state as AuthorizationAuthenticateSuccess).user));
                    }
                  },
                  icon: Icon(accepted ?? false ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined),
                ),
                Text("${idea.votes.where((element) => element.accepted).length}/${idea.votes.where((element) => !element.accepted).length}", style: const TextStyle(fontSize: 18)),
                IconButton(
                  color: Palette.decline,
                  onPressed: (){
                    AuthorizationBloc bloc = context.read<AuthorizationBloc>();

                    if(bloc.state is! AuthorizationAuthenticateSuccess){
                      return;
                    }

                    if(accepted == null || accepted == true){
                      context.read<IdeasBloc>().add(IdeasVoted(false, idea,(bloc.state as AuthorizationAuthenticateSuccess).user));
                    }
                  },
                  icon: Icon(accepted ?? true ? Icons.thumb_down_alt_outlined : Icons.thumb_down_alt),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
