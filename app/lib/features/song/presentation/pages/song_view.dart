import 'package:band_app/core/constants/environment.dart';
import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_state.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:band_app/features/song/presentation/widgets/music_player.dart';
import 'package:band_app/features/song/presentation/widgets/video_player.dart';
import 'package:band_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SongView extends StatefulWidget {
  final int id;

  const SongView({super.key, required this.id});

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text('Písničky'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider<SongBloc>(
      create: (context) => sl<SongBloc>()..add(LoadSong(widget.id)),
      child: BlocConsumer<SongBloc, SongState>(
        builder: (BuildContext context, SongState state) {
          if (state is SongLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.songEntity.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(state.songEntity.poster,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(state.songEntity.text ?? "",
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Theme.of(context).colorScheme.background),
                              fixedSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width - 40, 50)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ))),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                                  ),
                                  builder: (_) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(state.songEntity.text ?? "",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme.of(context).colorScheme.onSurface,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                          50)),
                                            ),
                                            onPressed: () {
                                              context.pop(context);
                                            },
                                            child: Text("Zavřít",
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Text("Zobrazit více",
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    state.songEntity.hasVideo
                        ? VideoPlayer(
                            url:
                                "${Environment.apiUrl}/songs/video/${state.songEntity.id}")
                        : const SizedBox(
                            height: 200,
                            child: Center(child: Text("Video nenalezeno")),
                          ),
                    Divider(
                      color: Theme.of(context).colorScheme.onSurface,
                      thickness: 2,
                      height: 40,
                    ),
                    state.songEntity.hasSound
                        ? MusicPlayer(
                            url:
                                "${Environment.apiUrl}/songs/sound/${state.songEntity.id}")
                        : const SizedBox(
                            height: 150,
                            child: Center(child: Text("Písnička nenalezena")),
                          ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<SongBloc>()
                            .add(DeleteSong(state.songEntity.id));
                      },
                      child: Text("Odstranit",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSurface
              ),
            );
          }
        },
        listener: (BuildContext context, SongState state) {
          if (state is SongDeleted) {
            context.read<SongsBloc>().add(RemoveSong(state.songEntity));
            context.pop(context);
          }
        },
      ),
    );
  }
}
