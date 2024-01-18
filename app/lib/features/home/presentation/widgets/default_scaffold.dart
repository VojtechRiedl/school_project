import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultScaffold extends StatelessWidget{
  final Widget ? title;
  final Widget ? body;
  final int index;

  const DefaultScaffold({super.key, this.body, this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.white,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () {
          if(index != 0) {
            GoRouter.of(context).pushReplacementNamed('home');
          }
        },
        backgroundColor: index == 0 ? Palette.first : Palette.fourth,
        child: const Icon(Icons.home, color: Palette.fifth, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: DefaultAppBar(title: title),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        height: 60,
        color: Palette.fifth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  if(index != 1){
                    GoRouter.of(context).pushReplacementNamed('ideas');
                  }
                },
                icon:  Icon(Icons.article, size: 24, color: index == 1 ? Palette.first : Palette.fourth),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: IconButton(
                onPressed: () {
                  if(index != 2){
                    GoRouter.of(context).pushReplacementNamed('songs');
                  }
                },
                icon:  Icon(Icons.queue_music, size: 24,color: index == 2 ? Palette.first : Palette.fourth),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: IconButton(
                onPressed: () {
                  if(index != 3) {
                    GoRouter.of(context).pushReplacementNamed('plans');
                  }
                },
                icon:  Icon(Icons.calendar_month, size: 24, color: index == 3 ? Palette.first : Palette.fourth),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                onPressed: () {
                  if(index != 4){
                    //GoRouter.of(context).pushReplacement('/settings');
                  }
                },
                icon:  Icon(Icons.settings, size: 24, color: index == 4 ? Palette.first : Palette.fourth),
              ),
            ),
          ],
        ),
      ),
      body: body,
    );
  }

}