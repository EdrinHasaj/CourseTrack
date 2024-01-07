import 'package:course_app/course_categories/diagnostics.dart';
import 'package:course_app/course_categories/goals.dart';
import 'package:course_app/course_categories/reflections.dart';
import 'package:course_app/course_categories/syllabus.dart';
import 'package:course_app/course_categories/upcoming_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final List<String> courseCategories = [
  "Syllabus",
  "Goals",
  "Journal",
  "Diagnostics",
  "Upcoming Events"
];

class CourseHomePage extends StatelessWidget {
  final String courseName;
  const CourseHomePage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(courseName),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                itemCount: 5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  if (index < courseCategories.length) {
                    return GestureDetector(
                      onTap: () {
                        navigateToCategoryPage(context, index);
                      },
                      child: Container(
                        height: index < 3 ? 150 : 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blue,
                        ),
                        child: Align(
                          alignment: index < 3
                              ? Alignment.topCenter
                              : Alignment.topLeft,
                          child: Padding(
                            padding: index < 3
                                ? EdgeInsets.only(top: 25)
                                : const EdgeInsets.all(16.0),
                            child: Text(
                              courseCategories[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: index < 3 ? 14.0 : 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Return an empty container if the index is out of bounds
                  }
                },
                staggeredTileBuilder: (index) {
                  if (index < 3) {
                    return StaggeredTile.fit(1);
                  } else {
                    return StaggeredTile.fit(3);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToCategoryPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Syllabus(
              courseCategory: courseCategories[0],
              courseName: courseName,
            ),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Goals(
              courseCategory: courseCategories[1],
              courseName: courseName,
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Reflections(
                courseName: courseCategories[2], courseCategory: courseName),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Diagnostics(
                courseName: courseCategories[3], courseCategory: courseName),
          ),
        );
        break;
      case 4:
        // Show a dialog for Upcoming Events
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpcomingEvents(
                courseName: courseCategories[4], courseCategory: courseName);
          },
        );
        break;
    }
  }
}
