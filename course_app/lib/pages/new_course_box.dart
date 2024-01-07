import 'package:flutter/material.dart';

class EnterNewCourseBox extends StatelessWidget {
  final controller;
  final controller2;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const EnterNewCourseBox(
      {super.key,
      required this.controller,
      required this.controller2,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text('Enter New Course', style: TextStyle(color: Colors.white)),
      content: Container(
        height: MediaQuery.of(context).size.height *
            0.2, // Adjust the height as needed
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Course Code'),
            ),
            TextField(
              controller: controller2,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Course Name'),
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
        MaterialButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
      ],
    );
  }
}
