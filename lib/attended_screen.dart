import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dashboard_screen.dart';

class AttendedScreen extends StatefulWidget {
  @override
  _AttendedScreenState createState() => _AttendedScreenState();
}

class _AttendedScreenState extends State<AttendedScreen> {
  int currentTab = 0; // 0 = Auto Checkin, 1 = Manual, 2 = Logs
  bool scanSuccess = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar
            Container(
              width: 160,
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => DashboardScreen()),
                      );
                    },
                  ),
                  CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                  SizedBox(height: 8),
                  Text("Mrs. Lina", style: TextStyle(fontWeight: FontWeight.bold)),
                  Divider(),
                  _navButton("Auto Checkin", 0),
                  _navButton("Manually Checkin", 1),
                  _navButton("Activity Logs", 2),
                  Spacer(),
                  _navButton("About Me", 3, isDisabled: true),
                ],
              ),
            ),

            // Center Scanning / Manual / Logs panel
            Expanded(
              flex: 2,
              child: Center(child: _buildCenterPanel()),
            ),

            // Right: Info or Form
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: currentTab == 1 ? _manualCheckinForm() : _studentInfo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(String title, int tabIndex, {bool isDisabled = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: isDisabled
            ? null
            : () => setState(() {
          currentTab = tabIndex;
        }),
        child: Text(
          title,
          style: TextStyle(
            color: isDisabled ? Colors.grey : (currentTab == tabIndex ? Colors.blue : Colors.black),
            fontWeight: currentTab == tabIndex ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCenterPanel() {
    if (currentTab == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.blue, width: 3),
            ),
            child: Center(child: Text("Face Scan")),
          ),
          SizedBox(height: 24),
          Text(
            scanSuccess ? "SUCCESS" : "SCAN FAILED",
            style: TextStyle(
              color: scanSuccess ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (currentTab == 1) {
      return Icon(Icons.person_search, size: 120, color: Colors.blue);
    } else {
      return _logsList();
    }
  }

  Widget _studentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Student Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 16),
        _info("Name", "Mrs. Legion Commander"),
        _info("Student ID", "123456789"),
        _info("Program", "Software Engineering"),
        _info("Major", "AI"),
        _info("School", "Information Technology"),
      ],
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  Widget _manualCheckinForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Student ID",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: "Full Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Confirm to Teacher"),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Reject"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _logsList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: List.generate(5, (index) {
          return ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text("Student ${index + 1} checked in"),
            subtitle: Text("2025-04-2${index + 1} 09:00 AM"),
          );
        }),
      ),
    );
  }
}
