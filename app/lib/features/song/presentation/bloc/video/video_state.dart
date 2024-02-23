import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

class VideoLoaded extends VideoState {

  final ChewieController chewieController;

  const VideoLoaded(this.chewieController);

  @override
  List<Object?> get props => [chewieController];
}