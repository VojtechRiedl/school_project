import 'package:equatable/equatable.dart';

class SongEntity extends Equatable{
  final int id;
  final String title;
  final DateTime created;
  final bool hasVideo;
  final bool hasSound;
  final String ? youtubeUrl;
  final String ? text;
  final String poster;

  const SongEntity({
    required this.id,
    required this.title,
    required this.created,
    required this.hasVideo,
    required this.hasSound,
    this.youtubeUrl,
    this.text,
    required this.poster,
  });

  @override
  List<Object?> get props => [id, title,created, youtubeUrl, text, poster, hasVideo, hasSound];

}