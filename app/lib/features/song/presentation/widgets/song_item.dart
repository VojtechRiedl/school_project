import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  song.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed("update-song", pathParameters: {'id': song.id.toString()});
                    },
                    icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            GoRouter.of(context).pushNamed("song", pathParameters: {'id': song.id.toString()});
          },
        )
      )
    );
  }
}