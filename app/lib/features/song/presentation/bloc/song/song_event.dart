import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();

  @override
  List<Object> get props => [];
}

class LoadSong extends SongEvent {
  final int id;

  const LoadSong(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteSong extends SongEvent {
  final int id;

  const DeleteSong(this.id);

  @override
  List<Object> get props => [id];
}