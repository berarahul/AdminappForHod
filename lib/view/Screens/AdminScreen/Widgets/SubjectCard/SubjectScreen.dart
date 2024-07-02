import 'package:flutter/material.dart';

class SubjectActionsScreen extends StatelessWidget {
  const SubjectActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Subject'),
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Add new subject',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Update subject',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Remove subject',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
