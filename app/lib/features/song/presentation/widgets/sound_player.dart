import 'package:audioplayers/audioplayers.dart';
import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';

class SoundPlayer extends StatefulWidget {
  final String url;

  const SoundPlayer({Key? key, required this.url}) : super(key: key);

  @override
  State<SoundPlayer> createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  final AudioPlayer audioPlayer = AudioPlayer();
  PlayerState state = PlayerState.paused;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    audioPlayer.setSourceUrl(widget.url);

    audioPlayer.onPlayerStateChanged.listen((event) {
      if(event == PlayerState.disposed) return;
      setState(() {
        state = event;
      });
    });

    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
         audioPlayer.setSourceUrl(widget.url);
      });
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void dispose() {
    Future.wait([audioPlayer.dispose()]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  value: position.inSeconds.toDouble(),
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (double value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);

                    await audioPlayer.resume();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      formatTime(position),
                      style: const TextStyle(
                        color: Palette.second,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        color: Palette.first,
                        onPressed: () async{
                          if(state == PlayerState.playing) {
                            await audioPlayer.pause();
                          }else if(state == PlayerState.paused) {
                            await audioPlayer.resume();
                          }else if(state == PlayerState.completed){
                            await audioPlayer.seek(Duration.zero);
                            await audioPlayer.resume();
                          }

                        },
                        icon: getIcon()
                    ),
                    Text(
                      formatTime(duration),
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

  Icon getIcon(){
    if(state == PlayerState.playing){
      return const Icon(Icons.pause, size: 32);
    }else if(state == PlayerState.paused){
      return const Icon(Icons.play_arrow, size: 32);
    }else if(state == PlayerState.completed){
      return const Icon(Icons.replay, size: 32);
    }else{
      return const Icon(Icons.error, size: 32);
    }
  }

}