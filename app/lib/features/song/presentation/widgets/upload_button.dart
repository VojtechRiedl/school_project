import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final String label;

  final bool loaded;

  const UploadButton({
    Key? key,
    required this.onPressed, required this.label, required this.loaded,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Palette.secondLight,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
        trailing: Icon(
          loaded ? Icons.file_download_done : Icons.file_upload_outlined,
          color: Palette.secondDark,
        ),
        title: Text(
          label,
          style: const TextStyle(
            color: Palette.secondDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}