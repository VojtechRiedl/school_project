import 'dart:ui';

import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlanInput extends StatelessWidget{

  final bool multiLine;

  final String ? label;

  final TextEditingController controller;

  final String ? errorText;

  const PlanInput({super.key, required this.multiLine, required this.label, required this.controller, this.errorText});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: multiLine ? 180 : null,
        child: TextField(
            controller: controller,
            minLines: multiLine ? 10 : 1,
            maxLines: multiLine ? null : 1,
            keyboardType: multiLine ? TextInputType.multiline : TextInputType.text,
            decoration: InputDecoration(
              labelText: multiLine ? null : label,
              hintText: multiLine ? label : null,
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
              labelStyle: Theme.of(context).textTheme.labelMedium,
              hintStyle: Theme.of(context).textTheme.labelMedium,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              errorText: errorText,
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  color: Palette.error,
                  width: 2,
                ),
              ),
              errorStyle: const TextStyle(
                color: Palette.error,
              ),
            )
        ),
      ),
    );
  }

}