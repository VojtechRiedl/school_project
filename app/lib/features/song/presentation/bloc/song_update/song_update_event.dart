import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class SongUpdateEvent extends Equatable {
  const SongUpdateEvent();

  @override
  List<Object> get props => [];
}

class LoadSong extends SongUpdateEvent {
  final int id;

  const LoadSong(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateSong extends SongUpdateEvent {
  final int id;
  final String title;
  final String ? youtubeLink;
  final String ? text;

  const UpdateSong(this.title, this.youtubeLink, this.text, this.id);

  @override
  List<Object> get props => [title, youtubeLink!, text!, id];
}

class LoadVideo extends SongUpdateEvent {
  final FilePickerResult ? file;

  const LoadVideo(this.file);

  @override
  List<Object> get props => [file!];
}

class LoadSound extends SongUpdateEvent {
  final FilePickerResult ? file;

  const LoadSound(this.file);

  @override
  List<Object> get props => [file!];
}