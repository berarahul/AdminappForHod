import 'package:flutter/material.dart';
import 'package:attendanceadmin/constant/AppColors.dart';

class TeacherActionsScreen extends StatelessWidget {
  final List<String> actions = [
    'Add teacher',
    'Remove Teacher',
    'Update teacher',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appcolor,
        title: const Text('Teacher'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Teacher',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Define actions for each item tap here
                      },
                      child: Text(
                        actions[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
