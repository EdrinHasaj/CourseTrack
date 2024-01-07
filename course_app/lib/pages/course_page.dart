import 'package:course_app/pages/course_tile.dart';
import 'package:course_app/pages/my_fab.dart';
import 'package:course_app/pages/new_course_box.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List myCourses = [];

  // create a new course
  final _newCourseBoxController = TextEditingController();
  final _newCourseBoxController2 = TextEditingController();

  // add a course
  void addCourse() {
    // show a dialog for user to enter course details
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewCourseBox(
            controller: _newCourseBoxController,
            controller2: _newCourseBoxController2,
            onSave: saveNewCourse,
            onCancel: cancelNewCourse,
          );
        });
  }

  void cancelNewCourse() {
    // clear textfield
    _newCourseBoxController.clear();
    _newCourseBoxController2.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  void saveNewCourse() {
    // add course to list
    setState(() {
      myCourses.add(
          _newCourseBoxController.text + ": " + _newCourseBoxController2.text);
    });
    // clear textfield
    _newCourseBoxController.clear();
    _newCourseBoxController2.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // open course settings
  void openCourseSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewCourseBox(
              controller: _newCourseBoxController,
              controller2: _newCourseBoxController2,
              onSave: () => saveExistingCourse(index),
              onCancel: cancelNewCourse);
        });
  }

  // save existing course with a new name
  void saveExistingCourse(int index) {
    setState(() {
      myCourses[index] =
          _newCourseBoxController.text + ": " + _newCourseBoxController2.text;
    });
    _newCourseBoxController.clear();
    _newCourseBoxController2.clear();
    Navigator.pop(context);
  }

  // delete course
  void deleteCourse(int index) {
    setState(() {
      myCourses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Courses"),
      ),
      floatingActionButton: MyFloatingActionButton(onPressed: addCourse),
      body: ListView.builder(
          itemCount: myCourses.length,
          itemBuilder: (context, index) {
            return CourseTile(
              courseName: myCourses[index],
              settingsTapped: (context) => openCourseSettings(index),
              deleteTapped: (context) => deleteCourse(index),
            );
          }),
    );
  }
}
