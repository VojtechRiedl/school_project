import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/song/presentation/bloc/video/video_cubit.dart';
import 'package:band_app/features/song/presentation/bloc/video/video_state.dart';
import 'package:band_app/injection_container.dart';
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
      create: (context) => sl<VideoCubit>()..loadVideo(widget.url),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (BuildContext context, VideoState state) {
          if(state is VideoLoaded){
            return _buildVideoPlayer(state.chewieController);
          }
          return _buildLoading();
        },
      ),
    );
  }


  Widget _buildVideoPlayer(ChewieController chewieController) {

      return Container(
        color: Colors.transparent,
        height: 200,
        child: chewieController
            .videoPlayerController.value.isInitialized
            ? AspectRatio(
          aspectRatio: chewieController.aspectRatio!,
          child: Chewie(
            controller: chewieController,
          ),
        )
            : _buildLoading());

  }

  Widget _buildLoading() {
    return SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface,),
      ),
    );
  }
}