import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:band_app/features/song/domain/entites/song.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongSearchBar extends StatelessWidget {
  final List<SongModel> suggestions;

  const SongSearchBar({
    Key? key, required this.suggestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        labelText: 'Vyhledat...',
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        labelStyle: Theme.of(context).textTheme.labelMedium,
        suffixIcon: Icon(Icons.search, color: Theme.of(context).textTheme.labelMedium?.color),
        ),
      onChanged: (value) {
        context.read<SongsBloc>().add(SearchSongs(value, suggestions));
      },
    );
  }
}