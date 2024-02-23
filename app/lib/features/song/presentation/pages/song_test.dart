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

class SongTest extends StatefulWidget {
  final int id;

  const SongTest({super.key, required this.id});

  @override
  State<SongTest> createState() => _SongTestState();
}

class _SongTestState extends State<SongTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.light,
      appBar: const MainAppBar(

        title: Text('Písničky'),
      ),
      body:_buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return BlocProvider<SongBloc>(
      create: (context) => sl<SongBloc>()..add(LoadSong(widget.id)),
      child: BlocConsumer<SongBloc, SongState>(
        builder: (BuildContext context, SongState state) {
          if(state is SongLoaded){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Text(state.songEntity.title, style: TextStyle(fontSize: 24, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
                Text(state.songEntity.poster, style: TextStyle(fontSize: 16, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(state.songEntity.text ?? "",
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Palette.dark),
                          fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 40, 50)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ))),
                        ),
                        onPressed: (){
                          showModalBottomSheet(context: context, builder: (BuildContext context){
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.songEntity.text ?? "",
                                      style: const TextStyle(fontSize: 16, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 20),
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
                                      context.pop(context);
                                    },
                                    child: const Text("Zavřít", style: TextStyle(color: Palette.light, fontSize: 16, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                        child: const Text("Zobrazit více", style: TextStyle(color: Palette.light, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                const VideoPlayer(url: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),

                const SizedBox(height: 20),

                const MusicPlayer(),

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
                    context.read<SongBloc>().add(DeleteSong(state.songEntity.id));
                  },
                  child: const Text("Odstranit", style: TextStyle(color: Palette.yellow, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                ],
              ),
            ),
          );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: Palette.dark,),
            );
          }
        },
        listener: (BuildContext context, SongState state) {
          if(state is SongDeleted){
            context.read<SongsBloc>().add(RemoveSong(state.songEntity));
            context.pop(context);
          }
        },
      ),
    );
  }
}