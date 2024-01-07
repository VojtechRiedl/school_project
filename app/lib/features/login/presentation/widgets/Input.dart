import 'package:band_app/core/constatns/palette.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget{
  final String label;
  final bool obscured;
  final String ? errorText;
  final TextEditingController controller;

  const Input({super.key, required this.label, required this.obscured, required this.controller ,this.errorText});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscured,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Palette.second, width: 2.0),
        ),
        focusColor: Palette.first,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Palette.first, width: 2.0),
        ),
        labelStyle: TextStyle(color: widget.errorText == null ?  Palette.first : Palette.decline),
        errorText: widget.errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Palette.decline, width: 2.0),
        ),
        errorStyle: const TextStyle(color: Palette.decline),
      ),

    );
  }
}