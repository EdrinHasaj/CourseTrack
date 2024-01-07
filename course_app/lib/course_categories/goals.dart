import 'package:course_app/course_categories/goal_box.dart';
import 'package:course_app/course_categories/goal_tile.dart';
import 'package:flutter/material.dart';

class Goals extends StatefulWidget {
  final String courseCategory;
  final String courseName;
  const Goals(
      {super.key, required this.courseCategory, required this.courseName});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  List dailyGoals = [
    ["Code", false]
  ];

  bool goalCompleted = false;

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      dailyGoals[index][1] = value;
    });
  }

  final controller = TextEditingController();
  void createNewGoal() {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewGoalBox(
            controller: controller,
            onSave: saveNewGoal,
            onCancel: cancelNewGoal,
          );
        });
  }

  void saveNewGoal() {
    setState(() {
      dailyGoals.add([controller.text, false]);
    });
    controller.clear();
    Navigator.of(context).pop();
  }

  void cancelNewGoal() {
    controller.clear();
    Navigator.of(context).pop();
  }

  void openGoalSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewGoalBox(
              controller: controller,
              onSave: () => saveExistingGoal(index),
              onCancel: cancelNewGoal);
        });
  }

  void saveExistingGoal(int index) {
    setState(() {
      dailyGoals[index][0] = controller.text;
    });
    controller.clear();
    Navigator.pop(context);
  }

  void deleteGoal(int index) {
    setState(() {
      dailyGoals.removeAt(index);
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
          IconButton(onPressed: createNewGoal, icon: Icon(Icons.add)),
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
          itemCount: dailyGoals.length,
          itemBuilder: (context, index) {
            return GoalTile(
              goalName: dailyGoals[index][0],
              goalCompleted: dailyGoals[index][1],
              onChanged: (value) => checkBoxTapped(value, index),
              settingsTapped: (context) => openGoalSettings(index),
              deleteTapped: (context) => deleteGoal(index),
            );
          }),
    );
  }
}
