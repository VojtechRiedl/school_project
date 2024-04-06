import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PlanWidget extends StatelessWidget{
  final List<PlanModel> plans;
  final DateTime date;

  const PlanWidget({Key? key, required this.plans, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DateFormat("dd/MM/yyyy").format(date), textAlign: TextAlign.start, style: TextStyle(fontSize: 16),),
        Divider(color: Theme.of(context).colorScheme.onSurface, height: 20, thickness: 1),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: plans.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(plans[index].title, textAlign: TextAlign.center,),
                onTap: (){
                  GoRouter.of(context).pushNamed("plan", pathParameters: {"id": plans[index].id.toString()});
                },
              ),
            );
          },separatorBuilder: (context, index) => const SizedBox(height: 5),
        )
      ],
    );
  }
}