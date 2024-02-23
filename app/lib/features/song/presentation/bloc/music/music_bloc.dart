import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:band_app/features/song/presentation/bloc/music/music_event.dart';
import 'package:band_app/features/song/presentation/bloc/music/music_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState>{
  final AudioPlayer audioPlayer;

  late StreamSubscription<Duration> onPositionChanged;
  late StreamSubscription<Duration> onDurationChanged;
  late StreamSubscription<void> onPlayerComplete;

  MusicBloc(this.audioPlayer) : super(const MusicInitial()){
    on<MusicLoaded>(_onMusicLoaded);
    on<MusicCompleted>(_onMusicCompleted);
    on<MusicPaused>(_onMusicPaused);
    on<MusicPlayed>(_onMusicPlayed);
    on<MusicPositionChanged>(_onMusicPositionChanged);
    on<MusicDurationChanged>(_onMusicDurationChanged);
    on<MusicRestarted>(_onMusicRestarted);
    on<MusicSeeked>(_onMusicSeeked);
  }


  void _onMusicLoaded(MusicLoaded event, Emitter<MusicState> emit) async {
    await audioPlayer.setSourceUrl(event.url);


    onPositionChanged = audioPlayer.onPositionChanged.listen((event) async {
      add(MusicPositionChanged(position: event));
    });

    onDurationChanged = audioPlayer.onDurationChanged.listen((event) {
      add(MusicDurationChanged(duration: event));
    });

    onPlayerComplete = audioPlayer.onPlayerComplete.listen((event) {
      add(const MusicCompleted());
    });

    Duration? duration = await audioPlayer.getDuration();

    emit(MusicLoadSuccess(duration: duration ?? Duration.zero));
  }

  void _onMusicCompleted(MusicCompleted event, Emitter<MusicState> emit) {
    emit(MusicCompleteSuccess(duration: state.duration, position: state.position));
  }

  void _onMusicPaused(MusicPaused event, Emitter<MusicState> emit) async {
    await audioPlayer.pause();
    emit(MusicPauseSuccess(duration: state.duration, position: state.position));
  }

  void _onMusicPlayed(MusicPlayed event, Emitter<MusicState> emit) async {
    await audioPlayer.resume();
    emit(MusicPlaySuccess(duration: state.duration, position: state.position));
  }

  void _onMusicDurationChanged(MusicDurationChanged event, Emitter<MusicState> emit) {
    emit(MusicDurationChangeSuccess(duration: event.duration, position: state.position));
  }

  void _onMusicPositionChanged(MusicPositionChanged event, Emitter<MusicState> emit) async {
    emit(MusicPositionChangeSuccess(duration: state.duration, position: event.position));
  }

  void _onMusicSeeked(MusicSeeked event, Emitter<MusicState> emit) async {
    await audioPlayer.seek(event.position);
    await audioPlayer.resume();
    MusicPositionChangeSuccess(duration: state.duration, position: event.position);
  }


  void _onMusicRestarted(MusicRestarted event, Emitter<MusicState> emit) async {
    /*await audioPlayer.seek(Duration.zero);
    await audioPlayer.resume();*/
    await audioPlayer.play(UrlSource(event.url));

    //add(MusicLoaded(url: event.url));
    emit(MusicLoadSuccess(duration: state.duration));
  }

  @override
  Future<void> close() {
    onPositionChanged.cancel();
    onDurationChanged.cancel();
    onPlayerComplete.cancel();
    audioPlayer.dispose();
    return super.close();
  }

}