import 'package:band_app/features/song/data/models/song_update.dart';
import 'package:equatable/equatable.dart';

class UpdateSongParams extends Equatable {
  final int id;
  final SongUpdateModel song;

  const UpdateSongParams({required this.id, required this.song});
  @override
  List<Object?> get props => [song, id];
}