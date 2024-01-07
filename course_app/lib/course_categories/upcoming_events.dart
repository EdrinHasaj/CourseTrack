import 'package:flutter/material.dart';

class UpcomingEvents extends StatelessWidget {
  final String courseName;
  final String courseCategory;

  UpcomingEvents({required this.courseName, required this.courseCategory});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(courseName + " - " + courseCategory),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("You can add more details or widgets here."),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
        ),
      ],
    );
  }
}