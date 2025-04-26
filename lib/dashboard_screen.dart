import 'package:flutter/material.dart';
import 'main.dart';
import 'my_course_screen.dart';
import 'student_register_screen.dart';
import 'course_register_screen.dart';
import 'schedule_screen.dart';
import 'attended_screen.dart';




class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> announcements = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
    'New class registration opens next Monday.',
    'Midterm results will be announced next week.'
  ];

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_currentPage < announcements.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/profile.png'), // Use your real image
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Martin Solo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('131241231', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today_outlined)),
                ],
              ),
            ),

            // Announcement
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Admin', style: TextStyle(color: Colors.white)),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: _previousPage,
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: _nextPage,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemCount: announcements.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              announcements[index],
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Grid Buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildButton(context, Icons.menu_book, 'My Course'),
                    _buildButton(context, Icons.check_circle, 'Attended'),
                    _buildButton(context, Icons.person_add_alt, 'Student Register'),
                    _buildButton(context, Icons.app_registration, 'Course Register'),
                    _buildButton(context, Icons.calendar_today, 'Schedule'),
                    _buildButton(context, Icons.bar_chart, 'Statistics'),
                  ],
                ),
              ),
            ),

            // Log Out
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: Text("Log Out"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        if (label == 'My Course') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MyCourseScreen()));
        } else if (label == 'Student Register') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => StudentRegisterScreen()));
        } else if (label == 'Course Register') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CourseRegisterScreen()));
        } else if (label == 'Schedule') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduleScreen())); // ✅ Add this
        }else if (label == 'Attended') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AttendedScreen()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DummyScreen(title: label)));
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DummyScreen extends StatelessWidget {
  final String title;
  DummyScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("This is the $title page")),
    );
  }
}
