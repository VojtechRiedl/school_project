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
        style: Theme.of(context).textTheme.bodyMedium,
        readOnly: true,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.onSurface),
            labelText: widget.label,
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        onTap: () async {
          DateTime ? pickedDate = await showDatePicker(
            context: context,
            initialDate: widget.controller.text != "" ? DateTime.parse(widget.controller.text) : DateTime.now(),
            currentDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(9999),
            builder: (BuildContext context, Widget ? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Theme.of(context).colorScheme.onSurface,
                    onPrimary: Theme.of(context).colorScheme.secondary,
                  ),
                  dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
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