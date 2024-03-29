import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/song/presentation/bloc/music/music_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/music/music_event.dart';
import 'package:band_app/features/song/presentation/bloc/music/music_state.dart';
import 'package:band_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicPlayer extends StatelessWidget{
  final String url; //= "https://onlinetestcase.com/wp-content/uploads/2023/06/500-KB-MP3.mp3";

  const MusicPlayer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MusicBloc>(
      create: (context) => sl<MusicBloc>()..add(MusicLoaded(url: url)),
      child: SizedBox(
        height: 150,
        //color: Palette.yellow,
        child: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            if(state is MusicInitial){
              return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface,));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Slider(
                    value: state.position.inSeconds.toDouble(),
                    min: 0,
                    max: state.duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      final position = Duration(seconds: value.toInt());
                      context.read<MusicBloc>().add(MusicSeeked(position: position));
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(state.position),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatTime(state.duration),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Palette.dark,
                      radius: 28,
                      child: action(context, state)
                  )
                )
              ]
            );


            return Card(
                color: Palette.fifth,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Slider(
                        allowedInteraction: SliderInteraction.tapAndSlide,
                        activeColor: Palette.first,
                        inactiveColor: Palette.third,
                        secondaryActiveColor: Palette.second,
                        value: state.position.inSeconds.toDouble(),
                        min: 0,
                        max: state.duration.inSeconds.toDouble(),
                        onChanged: (double value) async {
                          final position = Duration(seconds: value.toInt());
                          /*await audioPlayer.seek(position);

                          await audioPlayer.resume();*/
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            formatTime(state.position),
                            style: const TextStyle(
                              color: Palette.second,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              color: Palette.first,
                              onPressed: () async{
                                /*if(state == PlayerState.playing) {
                                  await audioPlayer.pause();
                                }else if(state == PlayerState.paused) {
                                  await audioPlayer.resume();
                                }else if(state == PlayerState.completed){
                                  await audioPlayer.seek(Duration.zero);
                                  await audioPlayer.resume();
                                }*/

                              },
                              icon: Icon(Icons.play_arrow)
                          )
                          ,
                          Text(
                            formatTime(state.duration),
                            style: const TextStyle(
                              color: Palette.second,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],

                  ),
                )
            );
          },
        ),
      ),
    );
  }


  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(":");
  }

  Widget action(BuildContext context, MusicState state) {
    if (state is MusicPauseSuccess || state is MusicLoadSuccess) {
      return ActionButton(icon: Icons.play_arrow, onPressed: () {
        context.read<MusicBloc>().add(const MusicPlayed());
      });
    } else if (state is MusicCompleteSuccess) {
      return ActionButton(icon: Icons.restart_alt, onPressed: () {
        context.read<MusicBloc>().add(MusicRestarted(url: url));
      });
    }else{
      return ActionButton(icon: Icons.pause, onPressed: () {
        context.read<MusicBloc>().add(const MusicPaused());
      });
    }
  }

}

class ActionButton extends StatelessWidget{
  final IconData icon;
  final Function onPressed;

  const ActionButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Icon(icon, size: 32, color: Palette.yellow),
    );
  }
}