import 'package:band_app/features/song/presentation/bloc/song/song_event.dart';
import 'package:band_app/features/song/presentation/bloc/song/song_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongBloc extends Bloc<SongEvent, SongState>{
  SongBloc() : super(const SongInitial());

}