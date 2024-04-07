import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_state.dart';
import 'package:band_app/features/song/presentation/widgets/song_item.dart';
import 'package:band_app/features/song/presentation/widgets/song_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SongsView extends StatefulWidget{
  const SongsView({super.key});

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView> {

  @override
  void initState() {
    context.read<SongsBloc>().add(const LoadSongs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Theme.of(context).colorScheme.onSurface,
        onRefresh: () async {
          context.read<SongsBloc>().add(const LoadSongs());
          return Future.delayed(const Duration(seconds: 2));

        },
        child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<SongsBloc, SongsState>(
        listener: (BuildContext context, SongsState state) {
          if (state is SongCreated){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Písnička byla úspěšně vytvořena"),
              ),
            );
          }else if(state is SongDeleted){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Písnička byla úspěšně smazána"),
              ),
            );
          }else if(state is SongUpdated){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Písnička byla úspěšně aktualizována"),
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
          if (state is SongsInitial) {
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface,),
            );
          }
          final suggestions = state is SongsSearched ? state.suggestions : state.songs;
          return Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 20),
            child: Column(
              children: [
                SongSearchBar(suggestions: state.songs),
                const SizedBox(height: 10),
                Expanded(
                    child: ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return SongItem(song: suggestions[index] as SongModel);
                      },
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      onPressed: (){
                        GoRouter.of(context).pushNamed("create-song");
                      },
                      child:  Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 32,)
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}