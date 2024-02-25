import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';

abstract class SongsState extends Equatable {
  final List<SongEntity> songs;
  const SongsState({this.songs = const []});

  @override
  List<Object> get props => [songs];
}

class SongsInitial extends SongsState {}

class SongsLoaded extends SongsState {
  const SongsLoaded(songs) : super(songs: songs);

  @override
  List<Object> get props => [songs];
}

class SongsSearched extends SongsState {
  final String query;
  final List<SongEntity> suggestions;

  const SongsSearched(this.query, this.suggestions, songs) : super(songs: songs);

  @override
  List<Object> get props => [query, suggestions];
}

class SongCreated extends SongsState {
  const SongCreated(songs) : super(songs: songs);

  @override
  List<Object> get props => [songs];
}

class SongDeleted extends SongsState {
  const SongDeleted(songs) : super(songs: songs);

  @override
  List<Object> get props => [songs];
}

class SongUpdated extends SongsState {
  const SongUpdated(songs) : super(songs: songs);

  @override
  List<Object> get props => [songs];
}