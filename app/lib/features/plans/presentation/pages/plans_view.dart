import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';

class PlansView extends StatelessWidget {
  const PlansView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      index: 3,
      title: Text(
        "Plány",
        style: TextStyle(
          fontSize: 20,
          color: Palette.first,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(),
    );
  }
}