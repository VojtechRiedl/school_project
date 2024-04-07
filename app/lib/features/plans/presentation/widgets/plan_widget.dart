import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/plans/data/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PlanWidget extends StatelessWidget{
  final List<PlanModel> plans;
  final DateTime date;

  final String ? title;

  const PlanWidget({Key? key, required this.plans, required this.date, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textColor: Theme.of(context).colorScheme.onSurface,
        iconColor: Theme.of(context).colorScheme.onSurface,
        title: Text("${title ?? ""} ${DateFormat("dd/MM/yyyy").format(date)}", textAlign: TextAlign.start, style: const TextStyle(fontSize: 16)),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 5,
                color: Theme.of(context).colorScheme.onSurface,
                thickness: 1,
              ),

              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero
                    ),
                    child: ListTile(
                      title: Text(plans[index].title, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center,),
                      onTap: (){
                        GoRouter.of(context).pushNamed("plan", pathParameters: {"id": plans[index].id.toString()});
                      },
                    ),
                  );
                },separatorBuilder: (context, index) => Divider(
                  height: 0,
                  indent: 10,
                  endIndent: 10,
                  color: Theme.of(context).colorScheme.onSurface,
                  thickness: 1,
              )
              )
            ],
          ),
        ],
      ),
    );
  }
}