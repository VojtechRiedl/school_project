import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/home/presentation/widgets/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultScaffold extends StatelessWidget{
  final Text ? title;
  final Widget ? body;
  final int index;
  final PageController pageController;

  const DefaultScaffold({super.key, this.body, this.title, required this.index, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Palette.light,
      appBar: MainAppBar(title: title),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomAppBar(

          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              NavigationItem(
                selectedIcon: Icons.article,
                unselectedIcon: Icons.article_outlined,
                isSelected: index == 0,
                index: 0,
                pageController: pageController,
              ),
              NavigationItem(
                selectedIcon: Icons.queue_music,
                unselectedIcon: Icons.queue_music_outlined,
                isSelected: index == 1,
                index: 1,
                pageController: pageController,
              ),
              NavigationItem(
                selectedIcon: Icons.home,
                unselectedIcon: Icons.home_outlined,
                isSelected: index == 2,
                index: 2,
                pageController: pageController,
              ),
              NavigationItem(
                selectedIcon: Icons.calendar_month,
                unselectedIcon: Icons.calendar_month_outlined,
                isSelected: index == 3,
                index: 3,
                pageController: pageController,
              ),
              NavigationItem(
                selectedIcon: Icons.settings,
                unselectedIcon: Icons.settings_outlined,
                isSelected: index == 4,
                index: 4,
                pageController: pageController,
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }

  int get actualIndex => index;

}