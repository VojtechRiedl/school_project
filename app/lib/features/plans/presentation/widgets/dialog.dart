import 'package:band_app/features/ideas/presentation/widgets/dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showDeletePlanDialog(BuildContext context){
  return showGenericDialog(
    context: context,
    title: 'Smazat plán',
    content: 'Opravdu chcete smazat plán?',
    optionsBuilder: () => {
      'Ne': false,
      'Ano': true,
    },
  ).then((value) => value ?? false);
}