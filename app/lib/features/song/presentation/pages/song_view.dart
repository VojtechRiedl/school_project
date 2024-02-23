import 'package:band_app/core/constants/environment.dart';
import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_state.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:band_app/features/song/presentation/widgets/sound_player.dart';
import 'package:band_app/injection_container.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class SongView extends StatefulWidget {
  final int id;

  const SongView({Key? key, required this.id}) : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {

  late VideoPlayerController ? _videoPlayerController;

  ChewieController ? _chewieController;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      pageController: PageController(initialPage: 2), //TODO předělat
      index: 2,
      title: const Text(
        "Písničky",
        style: TextStyle(
          fontSize: 20,
          color: Palette.lightTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return BlocProvider<SongBloc>(
      create: (_) => sl<SongBloc>()..add(LoadSong(widget.id)),
      child: BlocConsumer<SongBloc, SongState>(
        listener: (context, state) async {
          if(state is SongLoaded){
            if(state.songEntity.hasVideo){
              _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("${Environment.apiUrl}/songs/video/${state.songEntity.id}"));
              await _videoPlayerController!.initialize();

              _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController!,
                maxScale: 1,
                autoInitialize: true,
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                autoPlay: false,
                looping: false,
                deviceOrientationsAfterFullScreen: [
                  DeviceOrientation.portraitUp,
                ],
              );
              setState(() {

              });
            }
          }else if(state is SongDeleted){
            context.read<SongsBloc>().add(RemoveSong(state.songEntity));
            context.pop(context);
          }
        },
        builder: (context, state) {
          if(state is SongInitial){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is SongLoaded){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        color: Palette.fifth,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(state.songEntity.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        color: Palette.fifth,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Vytvořeno uživatelem", style: TextStyle(fontWeight: FontWeight.bold, color: Palette.second, fontSize: 16)),
                                Text(state.songEntity.poster, style: const TextStyle(fontWeight: FontWeight.bold, color: Palette.second, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    state.songEntity.youtubeUrl == null || state.songEntity.youtubeUrl!.isEmpty ? Container() :
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        color: Palette.fifth,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(state.songEntity.youtubeUrl!),
                          ),
                        ),
                      ),
                    ),
                    state.songEntity.text == null || state.songEntity.text!.isEmpty ? Container() :
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        color: Palette.fifth,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(state.songEntity.text!),
                          ),
                        ),
                      ),
                    ),
                    !state.songEntity.hasVideo ? Container() :
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                          ? AspectRatio(
                            aspectRatio: _chewieController!.aspectRatio!,
                            child: Chewie(
                        controller: _chewieController!,
                      ),
                          )
                          : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                    !state.songEntity.hasSound ? Container() :
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SoundPlayer(url: "${Environment.apiUrl}/songs/sound/${state.songEntity.id}",)
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                          color: Palette.decline,
                          child: ListTile(
                            title: const Text("Smazat", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Palette.white)),
                            onTap: () {
                              context.read<SongBloc>().add(DeleteSong(state.songEntity.id));
                            },
                          )
                      ),
                    ),

                  ],
                ),
              ),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
