import 'package:course_app/course_categories/syllabus_item_box.dart';
import 'package:course_app/course_categories/syllabus_tile.dart';
import 'package:flutter/material.dart';

class Syllabus extends StatefulWidget {
  final String courseCategory;
  final String courseName;
  const Syllabus({
    Key? key,
    required this.courseCategory,
    required this.courseName,
  }) : super(key: key);

  @override
  _SyllabusState createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  List syllabusItem = [
    ["Test 1", "01/04/24", "35%"],
    ["Test 2", "01/04/24", "35%"],
  ];

  final _newCourseBoxController = TextEditingController();
  final _newCourseBoxController2 = TextEditingController();
  final _newCourseBoxController3 = TextEditingController();

  // add syllabus item
  void createNewSyllabusItem() {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewSyllabusItem(
            controller: _newCourseBoxController,
            controller2: _newCourseBoxController2,
            controller3: _newCourseBoxController3,
            onSave: saveNewSyllabusItem,
            onCancel: cancelNewSyllabusItem,
          );
        });
  }

  void cancelNewSyllabusItem() {
    // clear textfield
    _newCourseBoxController.clear();
    _newCourseBoxController2.clear();
    _newCourseBoxController3.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  void saveNewSyllabusItem() {
    setState(() {
      syllabusItem.add([
        _newCourseBoxController.text,
        _newCourseBoxController2.text,
        _newCourseBoxController3.text
      ]);
    });
    _newCourseBoxController.clear();
    _newCourseBoxController2.clear();
    _newCourseBoxController3.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  void openSyllabusItemSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewSyllabusItem(
              controller: _newCourseBoxController,
              controller2: _newCourseBoxController2,
              controller3: _newCourseBoxController3,
              onSave: () => saveExistingSyllabusItem(index),
              onCancel: cancelNewSyllabusItem);
        });
  }

  void saveExistingSyllabusItem(int index) {
    setState(() {
      syllabusItem[index] = [
        _newCourseBoxController.text,
        _newCourseBoxController2.text,
        _newCourseBoxController3.text,
      ];
    });
    _newCourseBoxController.clear();
    _newCourseBoxController2.clear();
    _newCourseBoxController3.clear();
    Navigator.pop(context);
  }

  void deleteSyllabusItem(int index) {
    setState(() {
      syllabusItem.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: createNewSyllabusItem, icon: Icon(Icons.add)),
        ],
        // Add a back button to the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
          itemCount: syllabusItem.length,
          itemBuilder: (context, index) {
            return SyllabusTile(
              assessment: syllabusItem[index][0],
              date: syllabusItem[index][1],
              weight: syllabusItem[index][2],
              settingsTapped: (context) => openSyllabusItemSettings(index),
              deleteTapped: (context) => deleteSyllabusItem(index),
            );
          }),
    );
  }
}
