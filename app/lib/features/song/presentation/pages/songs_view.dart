import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_state.dart';
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
    return DefaultScaffold(
      index: 2,
      title: const Text(
        "Písničky",
        style: TextStyle(
          fontSize: 20,
          color: Palette.first,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<SongsBloc, SongsState>(
        builder: (BuildContext context, state) {
          if (state is SongsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final suggestions = state is SongsSearched ? state.suggestions : state.songs;
          return Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 40),
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
                  child: Card(
                    color: Palette.first,
                    child: ListTile(
                      title: const Icon(Icons.add, color: Palette.white,
                        size: 32),
                      onTap: () {
                        GoRouter.of(context).pushNamed("create-song");
                      }
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}