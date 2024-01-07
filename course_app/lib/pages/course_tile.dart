import 'package:course_app/pages/course_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CourseTile extends StatelessWidget {
  final String courseName;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const CourseTile(
      {super.key,
      required this.courseName,
      required this.settingsTapped,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          // settings option
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
          width: 1000,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: Row(children: [
            Text(courseName),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CourseHomePage(courseName: courseName)));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
