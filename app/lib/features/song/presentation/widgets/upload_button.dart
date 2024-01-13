import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final String label;

  const UploadButton({
    Key? key,
    required this.onPressed, required this.label,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Palette.second,
      child: ListTile(
        trailing: const Icon(
          Icons.file_upload_outlined,
          color: Palette.fifth,
        ),
        title: Text(
          label,
          style: const TextStyle(
            color: Palette.fifth,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}