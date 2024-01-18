import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class SongsEvent extends Equatable {
  const SongsEvent();

  @override
  List<Object> get props => [];
}

class LoadSongs extends SongsEvent {
  const LoadSongs();

  @override
  List<Object> get props => [];

}

class SearchSongs extends SongsEvent {
  final String query;
  final List<SongEntity> suggestions;

  const SearchSongs(this.query, this.suggestions);

  @override
  List<Object> get props => [query, suggestions];
}

class AddSong extends SongsEvent {
  final SongEntity song;


  const AddSong(this.song);

  @override
  List<Object> get props => [song];
}

class RemoveSong extends SongsEvent {
  final SongEntity song;


  const RemoveSong(this.song);

  @override
  List<Object> get props => [song];
}