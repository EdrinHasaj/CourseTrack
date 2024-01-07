import 'package:flutter/material.dart';

class Diagnostics extends StatelessWidget {
  final String courseName;
  final String courseCategory;

  Diagnostics({required this.courseName, required this.courseCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              courseName,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              courseCategory,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        // Add a back button to the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
