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
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textColor: Theme.of(context).colorScheme.onSurface,
        iconColor: Theme.of(context).colorScheme.onSurface,
        title: const Text("Naposledy přidané písničky", textAlign: TextAlign.start, style: TextStyle(fontSize: 16)),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.onSurface,
                thickness: 1,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(songs[index].title, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center,),
                      onTap: (){
                        GoRouter.of(context).pushNamed("song", pathParameters: {"id": songs[index].id.toString()});
                      },
                    ),
                  );
                },separatorBuilder: (context, index) => Divider(
                  height: 0,
                  indent: 20,
                  endIndent: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                  thickness: 1,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}