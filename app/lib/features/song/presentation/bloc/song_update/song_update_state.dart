import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class SongUpdateState extends Equatable {
  final FilePickerResult ? videoFileResult;
  final FilePickerResult ? songFileResult;

  const SongUpdateState({this.videoFileResult, this.songFileResult});

  @override
  List<Object?> get props => [videoFileResult, songFileResult];
}

class SongUpdateInitial extends SongUpdateState {}

class SongLoaded extends SongUpdateState {
  final SongEntity song;

  const SongLoaded(this.song);

  @override
  List<Object> get props => [song];
}

class SongUpdated extends SongUpdateState {
  final SongEntity song;

  const SongUpdated(this.song, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [song];
}

class SongUpdateError extends SongUpdateState {
  final String message;

  const SongUpdateError(this.message, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [message];
}

class SoundLoaded extends SongUpdateState {

  const SoundLoaded(songFile, videoFile) : super(videoFileResult: videoFile, songFileResult: songFile);

}

class VideoLoaded extends SongUpdateState {
  const VideoLoaded(songFile, videoFile) : super(songFileResult: songFile, videoFileResult: videoFile);
}

class UploadError extends SongUpdateState {
  final String message;

  const UploadError(this.message, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [message];
}

class TitleError extends SongUpdateState {
  final String message;

  const TitleError(this.message, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [message];
}

