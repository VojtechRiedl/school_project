import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      index: 0,
      title: Icon(
        size: 40,
        Icons.ac_unit,
        color: Palette.first,
      ),
      body: Center(

      ),

    );
  }
}