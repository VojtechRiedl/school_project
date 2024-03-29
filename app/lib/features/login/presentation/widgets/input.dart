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
      cursorColor: Theme.of(context).colorScheme.outline,
      maxLines: 1,
      controller: widget.controller,
      obscureText: widget.isObscured ? isObscure : false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        suffixIcon: widget.isObscured ? IconButton(
          onPressed: () => setState(() {
            isObscure = !isObscure;
          }),
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off, color: Theme.of(context).colorScheme.outline),
          color: Theme.of(context).colorScheme.outline,
        ) : null,
        labelText: widget.label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2.0),
        ),
        focusColor: Theme.of(context).colorScheme.outline,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2.0),
        ),
        labelStyle: TextStyle(color: widget.errorText == null ? Theme.of(context).textTheme.labelMedium?.color : Palette.error),
        errorText: widget.errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(width: 2.0),
        ),
      ),
    );
  }
}