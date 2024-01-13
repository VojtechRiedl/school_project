import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';

class IdeasView extends StatelessWidget{
  const IdeasView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      index: 1,
      title: Text(
        "Nápady",
        style: TextStyle(
          fontSize: 20,
          color: Palette.first,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(

      ),
    );
  }

}