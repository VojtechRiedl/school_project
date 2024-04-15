
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_bloc.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_event.dart';
import 'package:band_app/features/ideas/presentation/bloc/ideas/ideas_state.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_bloc.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_event.dart';
import 'package:band_app/features/plans/presentation/bloc/plans_state.dart';
import 'package:band_app/features/plans/presentation/widgets/plan_widget.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_state.dart';
import 'package:band_app/features/song/presentation/widgets/recently_add_song_widget.dart';
import 'package:band_app/features/user/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {

  final PageController pageController;

  const HomeView({super.key, required this.pageController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    context.read<SongsBloc>().add(const LoadSongs());
    context.read<PlansBloc>().add(const PlansFetched());
    context.read<IdeasBloc>().add(const IdeasLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onSurface,
      onRefresh: () async {
        context.read<SongsBloc>().add(const LoadSongs());
        context.read<PlansBloc>().add(const PlansFetched());
        context.read<IdeasBloc>().add(const IdeasLoaded());

        return Future.delayed(const Duration(seconds: 2));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.max,
          children: [
            Text("Vítej ${context.read<AuthorizationBloc>().state.user!.username}!",  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 20),textAlign: TextAlign.start,),
            const SizedBox(height: 20),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  loadSongs(context),
                  const Spacer(flex: 1),
                  loadPlans(context),
                  const Spacer(flex: 1),
                ],
              ),
            ),
            loadIdeas(context),
          ],
        ),
      ),
    );
  }

  Widget loadPlans(BuildContext context){
    return BlocBuilder<PlansBloc, PlansState>(
      builder: (context, state) {
        if(state is! PlansInitial){
          DateTime date = DateTime.now().copyWith(
            minute: 0,
            hour: 0,
            second: 0,
            microsecond: 0,
            millisecond: 0,
          );

          if(state.plans[date] == null){
            return Card(
                color: Theme.of(context).colorScheme.primary,
                child: ListTile(title: Text("Nebyly nalezeny žádné plány na dnešní den", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14))));

          }
          return PlanWidget(title: "Plány na den", plans: state.plans[date]!.toList(), date: date);
        }else{
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget loadSongs(BuildContext context){
    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        if(state is SongsLoaded){

          List<SongModel> songs = state.songs.where((element) => element.created.copyWith().add(const Duration(days: 2)).isAfter(DateTime.now())).toList();

          if(songs.isEmpty){
            return Card(
                color: Theme.of(context).colorScheme.primary,
                child: ListTile(title: Text("Žádné nové písničky nebyly přidány", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14))));


            return Container(
                height: 200,
                alignment: Alignment.center,
                child: const Text("Žádné nové písničky nebyly přidány"));
          }

          return RecentlyAddSongWidget(songs: songs);
        }else{
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget loadIdeas(BuildContext context){
    return BlocBuilder<IdeasBloc, IdeasState>(
      builder: (context, state) {
        if(state is IdeasLoadSuccess){

          UserModel user = context.read<AuthorizationBloc>().state.user!;

          state.ideas.where((element) => element.votes.where((element) => element.author.id == user.id).isEmpty).length;

          return Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Počet neodhlasovaných anket",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14), textAlign: TextAlign.center,),
                    Text("${state.ideas.where((element) => element.votes.where((element) => element.author.id == user.id).isEmpty).length}", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14),)
                  ],
                ),
              onTap: (){
                widget.pageController.jumpToPage(0);
              }
            ),
          );
        }else{
          return const CircularProgressIndicator();
        }
      },
    );
  }

}