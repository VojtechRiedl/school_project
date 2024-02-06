import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Text ? title;

  const DefaultAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      backgroundColor: Palette.appBarColor,
      centerTitle: true,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}