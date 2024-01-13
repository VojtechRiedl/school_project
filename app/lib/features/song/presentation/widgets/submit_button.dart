import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;

  const SubmitButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.accept,
      child: ListTile(
        title: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Palette.fifth,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}