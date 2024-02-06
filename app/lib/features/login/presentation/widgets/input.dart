import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget{
  final String label;
  final bool isObscured;
  final String ? errorText;
  final TextEditingController controller;

  const Input({super.key, required this.label, required this.isObscured, required this.controller ,this.errorText});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Palette.lightTextBoxTextColor),
      maxLines: 1,
      controller: widget.controller,
      obscureText: widget.isObscured ? isObscure : false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        suffixIcon: widget.isObscured ? IconButton(
          onPressed: () => setState(() {
            isObscure = !isObscure;
          }),
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off, color: Palette.lightTextBoxTextColor),
          color: Palette.darkOutlineTextBoxColor,
        ) : null,
        labelText: widget.label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Palette.darkOutlineTextBoxColor, width: 2.0),
        ),
        focusColor: Palette.darkOutlineTextBoxColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Palette.darkOutlineTextBoxColor, width: 2.0),
        ),
        labelStyle: TextStyle(color: widget.errorText == null ?  Palette.darkOutlineTextBoxColor : Palette.error),
        errorText: widget.errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Palette.error, width: 2.0),
        ),
        errorStyle: const TextStyle(color: Palette.error),
      ),
    );
  }
}