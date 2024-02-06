import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:band_app/features/home/presentation/bloc/navigation/navigation_state.dart';
import 'package:band_app/features/home/presentation/pages/home_view.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:band_app/features/ideas/presentation/pages/ideas_view.dart';
import 'package:band_app/features/plans/presentation/pages/plans_view.dart';
import 'package:band_app/features/song/presentation/pages/song_view.dart';
import 'package:band_app/features/song/presentation/pages/songs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final PageController _pageController = PageController(
    initialPage: 2,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (previous, current) => previous.currentPage != current.currentPage,
      builder: (BuildContext context, state) {
        //_pageController.animateToPage(state.currentPage, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
        return DefaultScaffold(
          pageController: _pageController,
            index: state.currentPage,
            title: const Text("Art Of The Crooked", style: TextStyle(color: Palette.lightTextColor, fontSize: 20, fontWeight: FontWeight.bold)),
            body: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                context.read<NavigationCubit>().changePage(index);
              },
              children: const [
                IdeasView(),
                SongsView(),
                HomeView(),
                PlansView(),
                Text("test")
              ],
            )
        );
      },
    );
  }
}