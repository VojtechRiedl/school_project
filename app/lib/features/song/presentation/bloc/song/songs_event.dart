import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';

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

class CreateSong extends SongsEvent {
  final String title;
  final String ? youtubeLink;
  final String ? text;

  const CreateSong(this.title, this.youtubeLink, this.text);

  @override
  List<Object> get props => [title, youtubeLink!, text!];
}