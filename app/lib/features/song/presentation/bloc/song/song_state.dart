import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';

abstract class SongState extends Equatable {

  const SongState();

  @override
  List<Object?> get props => [];
}

class SongInitial extends SongState {
  const SongInitial();
}

class SongLoaded extends SongState {
  final SongEntity songEntity;

  const SongLoaded(this.songEntity);

  @override
  List<Object?> get props => [songEntity];
}

class SongDeleted extends SongState {
  final SongEntity songEntity;

  const SongDeleted(this.songEntity);

  @override
  List<Object> get props => [songEntity];
}