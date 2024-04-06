
import 'package:band_app/features/plans/data/models/plan.dart';
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
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    context.read<SongsBloc>().add(const LoadSongs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(child: ListTile(title: Text(DateFormat("dd.MM.yyyy").format(DateTime.now()), style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,)),),
          const SizedBox(height: 20),
          loadSongs(context),
          const SizedBox(height: 20),
          loadPlans(context),
        ],
      ),
    );
  }

  Widget loadPlans(BuildContext context){
    return BlocBuilder<PlansBloc, PlansState>(
      builder: (context, state) {
        if(state is PlansLoadSuccess){
          DateTime date = DateTime.now().copyWith(
            minute: 0,
            hour: 0,
            second: 0,
            microsecond: 0,
            millisecond: 0,
          );

          if(state.plans[date] == null){
            return const CircularProgressIndicator();
          }
          return PlanWidget(plans: state.plans[date]!.toList(), date: date);
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
            return const SizedBox();
          }

          return RecentlyAddSongWidget(songs: songs);
        }else{
          return const CircularProgressIndicator();
        }
      },
    );
  }


}