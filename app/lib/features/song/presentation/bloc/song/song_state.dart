import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:equatable/equatable.dart';

abstract class SongState extends Equatable {
  final SongEntity ? songEntity;

  const SongState({this.songEntity});

  @override
  List<Object?> get props => [songEntity];
}

class SongInitial extends SongState {
  const SongInitial();
}