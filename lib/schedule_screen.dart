import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedTab = 0; // 0 = Upcoming, 1 = Finished
  int selectedDay = DateTime.now().weekday;

  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  List<Map<String, String>> classes = [
    {
      'section': 'Section 1',
      'code': '1305309',
      'name': 'Software Construction',
      'teacher': 'Ajs. Lwin Bhone Aung',
      'date': 'Tue'
    },
    {
      'section': 'Section 1',
      'code': '1305216',
      'name': 'Mobile Application',
      'teacher': 'Ajs. Myat Kaung Thant',
      'date': 'Tue'
    },
    {
      'section': 'Section 1',
      'code': '1305301',
      'name': 'Software Process',
      'teacher': 'Ajs. Ko Wai Tun',
      'date': 'Fri'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          // Month Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text("April 2025", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Day Selector
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                bool isSelected = index == selectedDay - 1;
                return GestureDetector(
                  onTap: () => setState(() => selectedDay = index + 1),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        weekDays[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 12),

          // Toggle Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => selectedTab = 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTab == 0 ? Colors.blue : Colors.grey[300],
                      foregroundColor: selectedTab == 0 ? Colors.white : Colors.black,
                    ),
                    child: Text("Upcoming Class"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => selectedTab = 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTab == 1 ? Colors.blue : Colors.grey[300],
                      foregroundColor: selectedTab == 1 ? Colors.white : Colors.black,
                    ),
                    child: Text("Finished Class"),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Class Cards
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: classes.where((cls) => cls['date'] == weekDays[selectedDay - 1]).map((course) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(course['section']!, style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 8),
                      // Course name
                      Text("${course['code']} ${course['name']}", style: TextStyle(fontWeight: FontWeight.bold)),
                      // Teacher
                      Text(course['teacher']!),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
