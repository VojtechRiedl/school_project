import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationItem extends StatelessWidget{
  final bool isSelected;
  final int index;

  final IconData selectedIcon;
  final IconData unselectedIcon;

  final PageController pageController;

  const NavigationItem({super.key, required this.isSelected, required this.index, required this.selectedIcon, required this.unselectedIcon, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        context.read<NavigationCubit>().changePage(index);
        pageController.jumpToPage(context.watch()<NavigationCubit>().state.currentPage);
      },
      icon:  Icon(
          isSelected ? selectedIcon : unselectedIcon,
          size: 24,
          color: isSelected ? Palette.yellow : Palette.light
      ),
    );
  }

}