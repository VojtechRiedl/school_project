import 'package:equatable/equatable.dart';

class SongEntity extends Equatable{
  final int id;
  final String title;
  final String ? youtubeUrl;
  final String ? text;
  final String poster;

  const SongEntity({
    required this.id,
    required this.title,
    this.youtubeUrl,
    this.text,
    required this.poster,
  });

  @override
  List<Object> get props => [id, title, youtubeUrl!, text!, poster];

}