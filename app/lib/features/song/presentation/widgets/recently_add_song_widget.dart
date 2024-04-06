import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:band_app/features/song/data/models/song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RecentlyAddSongWidget extends StatelessWidget{
  final List<SongModel> songs;

  const RecentlyAddSongWidget({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Naposledy přidané písničky", textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
        Divider(color: Theme.of(context).colorScheme.onSurface, height: 20, thickness: 1),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: songs.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(songs[index].title, textAlign: TextAlign.center,),
                onTap: (){
                  GoRouter.of(context).pushNamed("song", pathParameters: {'id': songs[index].id.toString()});
                },
              ),
            );
          },separatorBuilder: (context, index) => const SizedBox(height: 5),
        )
      ],
    );
  }
}