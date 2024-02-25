import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class SongCreateEvent extends Equatable {
  const SongCreateEvent();

  @override
  List<Object> get props => [];
}

class CreateSong extends SongCreateEvent {
  final int userId;
  final String title;
  final String ? youtubeLink;
  final String ? text;

  const CreateSong(this.title, this.youtubeLink, this.text, this.userId);

  @override
  List<Object> get props => [title, youtubeLink!, text!, userId];
}

class LoadVideo extends SongCreateEvent {
  final FilePickerResult ? file;

  const LoadVideo(this.file);

  @override
  List<Object> get props => [file!];
}

class LoadSound extends SongCreateEvent {
  final FilePickerResult ? file;

  const LoadSound(this.file);

  @override
  List<Object> get props => [file!];
}