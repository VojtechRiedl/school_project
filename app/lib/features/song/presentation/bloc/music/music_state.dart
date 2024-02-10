import 'package:equatable/equatable.dart';

abstract class MusicState extends Equatable {
  final Duration duration;
  final Duration position;

  const MusicState({this.duration = Duration.zero, this.position = Duration.zero});

  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {
  const MusicInitial();
}

class MusicLoadSuccess extends MusicState {
  const MusicLoadSuccess({required Duration duration}) : super(duration: duration);

  @override
  List<Object> get props => [duration];
}

class MusicPlaySuccess extends MusicState {
  const MusicPlaySuccess({required Duration position, required Duration duration}) : super(position: position, duration: duration);

  @override
  List<Object> get props => [position, duration];
}

class MusicPauseSuccess extends MusicState {
  const MusicPauseSuccess({required Duration position, required Duration duration}) : super(position: position, duration: duration);

  @override
  List<Object> get props => [position, duration];
}

class MusicCompleteSuccess extends MusicState {
  const MusicCompleteSuccess({required Duration position, required Duration duration}) : super(position: position, duration: duration);

  @override
  List<Object> get props => [position, duration];
}

class MusicDurationChangeSuccess extends MusicState {
  const MusicDurationChangeSuccess({required Duration position, required Duration duration}) : super(position: position, duration: duration);

  @override
  List<Object> get props => [position, duration];
}

class MusicPositionChangeSuccess extends MusicState {
  const MusicPositionChangeSuccess({required Duration position, required Duration duration}) : super(position: position, duration: duration);

  @override
  List<Object> get props => [position, duration];
}
