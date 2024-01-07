// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Class for a reflections note
class Note {
  String title;
  String date;
  String note;

  Note({required this.title, required this.date, required this.note});

  // Get a truncated version of the note text
  String get truncatedNote {
    const maxLength = 50; // Adjust the maximum length as needed
    return note.length <= maxLength
        ? note
        : '${note.substring(0, maxLength)}...';
  }
}

class Reflections extends StatefulWidget {
  final String courseName;
  final String courseCategory;
  const Reflections(
      {super.key, required this.courseName, required this.courseCategory});

  @override
  State<Reflections> createState() => _ReflectionsState();
}

class _ReflectionsState extends State<Reflections> {
  late String formattedDate;
  final TextEditingController _noteTextController = TextEditingController();
  final TextEditingController _addController = TextEditingController();
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    // Get the current date and format it
    DateTime currentDate = DateTime.now();
    formattedDate = DateFormat('MMM. d, y').format(currentDate);

    // Build the interface
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.courseName,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              widget.courseCategory,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: _showAddCourseDialog, icon: Icon(Icons.add)),
        ],
      ),

      // Body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Add your personal reflections.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildNoteButton(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // This function will add a new note
  void _showAddCourseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            controller: _addController,
            decoration: const InputDecoration(labelText: 'Enter title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String titleS = _addController.text;

                setState(() {
                  notes.add(Note(
                      title: titleS,
                      date: formattedDate,
                      note: 'Add your note.'));
                });
                Navigator.of(context).pop();
                _addController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // This method will build each individual note button
  Widget buildNoteButton(int index) {
    Note note = notes[index];

    return SizedBox(
      width: 50,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          _showNoteDialog(note);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              note.truncatedNote,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // This method is a handler method to show each note when opened
  void _showNoteDialog(Note note) {
    _noteTextController.text = note.note;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(note.title),
          content: TextField(
            controller: _noteTextController,
            maxLines: null,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  note.note = _noteTextController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
