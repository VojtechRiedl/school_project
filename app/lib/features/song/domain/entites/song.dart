import 'package:equatable/equatable.dart';

class SongEntity extends Equatable{
  final int id;
  final String title;
  final bool hasVideo;
  final bool hasSound;
  final String ? youtubeUrl;
  final String ? text;
  final String poster;

  const SongEntity({
    required this.id,
    required this.title,
    required this.hasVideo,
    required this.hasSound,
    this.youtubeUrl,
    this.text,
    required this.poster,
  });

  @override
  List<Object> get props => [id, title, youtubeUrl!, text!, poster, hasVideo, hasSound];

}