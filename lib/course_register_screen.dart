import 'package:flutter/material.dart';

class CourseRegisterScreen extends StatefulWidget {
  @override
  _CourseRegisterScreenState createState() => _CourseRegisterScreenState();
}

class _CourseRegisterScreenState extends State<CourseRegisterScreen> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Register"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(_codeController, "course Code", Icons.code),
            _buildTextField(_nameController, "Course Name", Icons.book),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement course registration logic
                },
                child: Text("Register"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
