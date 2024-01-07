import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GoalTile extends StatelessWidget {
  final String goalName;
  final bool goalCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const GoalTile(
      {
        super.key, 
        required this.goalName, 
        required this.goalCompleted,
        required this.onChanged,
        required this.settingsTapped,
        required this.deleteTapped,
        });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(15),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            )
          ]),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Expanded(
                child: Text(goalName),
              ),
              Checkbox(
                value: goalCompleted,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
