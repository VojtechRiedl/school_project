import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongSearchBar extends StatelessWidget {
  final List<SongEntity> suggestions;

  const SongSearchBar({
    Key? key, required this.suggestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Vyhledat',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: Palette.second,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: Palette.second,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: Palette.fourth,
        ),
        suffixIcon: Icon(Icons.search, color: Palette.second),
        ),
      onChanged: (value) {
        context.read<SongsBloc>().add(SearchSongs(value, suggestions));
      },
    );
  }
}