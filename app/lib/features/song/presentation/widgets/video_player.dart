import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/song/presentation/bloc/video/video_cubit.dart';
import 'package:band_app/features/song/presentation/bloc/video/video_state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget{
  final String url;

  const VideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoCubit>(
      create: (context) => VideoCubit()..loadVideo(widget.url),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (BuildContext context, VideoState state) {
          if(state is VideoLoaded){
            return Container(
              //color: Colors.yellow,
              height: 200,
              child: state.chewieController
                  .videoPlayerController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: state.chewieController.aspectRatio!,
                child: Chewie(
                  controller: state.chewieController,
                ),
              )
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Palette.dark,),
                ],
              ),
            );
          }
          return const CircularProgressIndicator(color: Palette.dark);
        },
      ),
    );
  }
}