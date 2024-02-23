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
        margin: const EdgeInsets.all(0),
        color: Palette.lightCard,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
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
                  style: const TextStyle(
                    color: Palette.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Palette.dark),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark, color: Palette.dark),
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