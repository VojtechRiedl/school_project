import 'package:band_app/features/song/presentation/bloc/video/video_state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<VideoState> {

  VideoPlayerController ? _videoPlayerController;

  ChewieController ? _chewieController;


  VideoCubit() : super(const VideoInitial());



  Future<void> loadVideo(String url) async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
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

    emit(VideoLoaded(_chewieController!));
  }

  @override
  Future<void> close() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    return super.close();
  }

}

