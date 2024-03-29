import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Text ? title;

  const MainAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}