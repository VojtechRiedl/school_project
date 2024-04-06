import 'package:band_app/features/song/domain/entites/song.dart';

class SongModel extends SongEntity{
  const SongModel({
    required int id,
    required String title,
    required DateTime created,
    required bool hasVideo,
    required bool hasSound,
    String ? youtubeUrl,
    String ? text,
    required String poster,
  }) : super (
    id: id,
    title: title,
    created: created,
    hasVideo: hasVideo,
    hasSound: hasSound,
    youtubeUrl: youtubeUrl,
    text: text,
    poster: poster,
  );

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    id: json['song_id'],
    title: json['name'],
    created: DateTime.parse(json['created']),
    hasVideo: json['video'],
    hasSound: json['sound'],
    youtubeUrl: json['yt_link'],
    text: json['text'],
    poster: json['user'],
  );

}