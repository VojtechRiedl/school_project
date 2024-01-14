import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class SongCreateState extends Equatable {
  final FilePickerResult ? videoFileResult;
  final FilePickerResult ? songFileResult;

  const SongCreateState({this.videoFileResult, this.songFileResult});

  @override
  List<Object?> get props => [videoFileResult, songFileResult];
}

class SongCreateInitial extends SongCreateState {}

class SongCreated extends SongCreateState {
  final SongEntity song;

  const SongCreated(this.song, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [song];
}

class SongCreateError extends SongCreateState {
  final String message;

  const SongCreateError(this.message, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [message];
}

class SoundLoaded extends SongCreateState {

  const SoundLoaded(songFile, videoFile) : super(videoFileResult: videoFile, songFileResult: songFile);

}

class VideoLoaded extends SongCreateState {
  const VideoLoaded(songFile, videoFile) : super(songFileResult: songFile, videoFileResult: videoFile);
}

class UploadError extends SongCreateState {
  final String message;

  const UploadError(this.message, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [message];
}

class TitleError extends SongCreateState {
  final String message;

  const TitleError(this.message, songFileResult, videoFileResult) : super(songFileResult: songFileResult, videoFileResult: videoFileResult);

  @override
  List<Object> get props => [message];
}

