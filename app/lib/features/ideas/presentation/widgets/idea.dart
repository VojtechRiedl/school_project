import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/ideas/data/models/idea.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IdeaWidget extends StatelessWidget {
  final IdeaModel idea;

  const IdeaWidget({
    Key? key,
    required this.idea,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.secondLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(idea.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text(DateFormat("yyyy-MM-dd").format(idea.deadline).toString(), style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: Palette.dark,
            thickness: 1,

          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas fermentum, sem in pharetra pellentesque, velit turpis volutpat ante, in pharetra metus odio a lectus. Etiam commodo dui eget wisi. Proin pede metus, vulputate nec, fermentum fringilla, vehicula vitae, justo. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Neque porro quisquam est.", style: TextStyle(fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${idea.author.username} ${DateFormat("yyyy-MM-dd").format(idea.created)}", style: const TextStyle(fontSize: 12)),
          ),
          const Divider(
            height: 0,
            color: Palette.dark,
            thickness: 1,

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                color: Palette.accept,
                onPressed: (){},
                icon: const Icon(Icons.thumb_up_alt_outlined),
              ),
              Text("${idea.votes.where((element) => element.accepted).length}/${idea.votes.where((element) => !element.accepted).length}", style: const TextStyle(fontSize: 18)),
              IconButton(
                color: Palette.decline,
                onPressed: (){},
                icon: const Icon(Icons.thumb_down_alt_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}
