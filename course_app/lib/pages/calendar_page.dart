import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              // rowHeight = 60;
              // daysOfWeekHeight = 60;
      
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.blue),
                formatButtonTextStyle: TextStyle(color: Colors.blue),
              ),
      
              calendarStyle: const CalendarStyle(
                //todayDecoration:
                //    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                selectedDecoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              ),
      
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
      
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
      
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
      
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },

              
      
      
            ),
          ),
        ],
      ),
    );
  }
}
