import 'package:equatable/equatable.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class MusicLoaded extends MusicEvent {
  final String url;

  const MusicLoaded({required this.url});

  @override
  List<Object> get props => [url];
}

class MusicPlayed extends MusicEvent {

  const MusicPlayed();

  @override
  List<Object> get props => [];
}

class MusicPaused extends MusicEvent {

  const MusicPaused();

  @override
  List<Object> get props => [];
}

class MusicDurationChanged extends MusicEvent {
  final Duration duration;

  const MusicDurationChanged({required this.duration});

  @override
  List<Object> get props => [duration];
}

class MusicPositionChanged extends MusicEvent {
  final Duration position;

  const MusicPositionChanged({required this.position});

  @override
  List<Object> get props => [position];
}

class MusicCompleted extends MusicEvent {

  const MusicCompleted();

  @override
  List<Object> get props => [];
}

class MusicRestarted extends MusicEvent {
  final String url;

  const MusicRestarted({required this.url});

  @override
  List<Object> get props => [url];
}

class MusicSeeked extends MusicEvent {
  final Duration position;

  const MusicSeeked({required this.position});

  @override
  List<Object> get props => [position];
}