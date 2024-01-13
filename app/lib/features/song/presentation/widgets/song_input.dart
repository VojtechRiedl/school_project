import 'dart:ui';

import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SongInput extends StatelessWidget{

  final bool multiLine;

  final String label;

  final TextEditingController controller;

  const SongInput({super.key, required this.multiLine, required this.label, required this.controller});


  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: multiLine ? 200 : null,
        child: TextField(
          controller: controller,
          minLines: multiLine ? 10 : 1,
          maxLines: multiLine ? null : 1,
          keyboardType: multiLine ? TextInputType.multiline : TextInputType.text,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: focusNode.hasFocus ? null : label,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: Palette.second,
                width: 2,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: Palette.second,
                width: 2,
              ),
            ),
            labelStyle: const TextStyle(
              color: Palette.second,
            ),
          )
        ),
      ),
    );
  }

}