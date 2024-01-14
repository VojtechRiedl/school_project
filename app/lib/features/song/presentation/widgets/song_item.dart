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
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: Palette.fifth,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                song.title,
                style: const TextStyle(
                  color: Palette.second,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Palette.second),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark, color: Palette.second),
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