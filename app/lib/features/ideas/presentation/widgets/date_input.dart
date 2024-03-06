import 'package:band_app/core/constants/palette.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget{

  final String ? label;

  final TextEditingController controller;

  const DateInput({super.key, required this.label, required this.controller});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        readOnly: true,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today, color: Palette.secondDark),
            labelText: widget.label,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: Palette.secondDark,
                width: 2,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: Palette.secondDark,
                width: 2,
              ),
            ),
            labelStyle: const TextStyle(
              color: Palette.secondDark,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        onTap: () async {
          DateTime ? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            currentDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2025),
            builder: (BuildContext context, Widget ? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Palette.dark,
                    onPrimary: Palette.light,
                    surface: Palette.light,
                    onSurface: Palette.dark,
                  ),
                  dialogBackgroundColor: Palette.light,
                ),
                child: child ?? const SizedBox(),
              );
            },

          );

          if (pickedDate != null) {
            setState(() {
              widget.controller.text = pickedDate.toString().split(" ")[0];
            });
          }
        },
      ),
    );
  }
}