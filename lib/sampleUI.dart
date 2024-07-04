

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TeacherUpdateScreen extends StatefulWidget {
  @override
  _TeacherUpdateScreenState createState() => _TeacherUpdateScreenState();
}

class _TeacherUpdateScreenState extends State<TeacherUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  List<int> _newSubjectIds = [];
  List<int> _removeSubjectIds = [];
  int teacherId = 123; // Example teacher ID

  // Example list of teachers (replace with your actual API call)
  List<String> teacherList = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Brown',
    'Robert Wilson',
  ];

  // Function to handle teacher selection from the list
  void selectTeacher(String teacherName) {
    setState(() {
      _nameController.text = teacherName;
    });
  }

  // Function to edit teacher name
  void editTeacherName(int index) async {
    String editedName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String currentName = teacherList[index];
        TextEditingController editingController = TextEditingController(text: currentName);
        return AlertDialog(
          title: Text('Edit Teacher Name'),
          content: TextField(
            controller: editingController,
            decoration: InputDecoration(hintText: 'Enter new name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(editingController.text);
              },
            ),
          ],
        );
      },
    );

    if (editedName != null && editedName.isNotEmpty) {
      setState(() {
        teacherList[index] = editedName;
      });
    }
  }

  Future<void> updateTeacher() async {
    final url = Uri.parse('https://api.example.com/teachers/$teacherId');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "teacherId": teacherId,
      "name": _nameController.text,
      "newSubjectIds": _newSubjectIds,
      "removeSubjectIds": _removeSubjectIds,
    });

    // Simulated HTTP request to update teacher
    await Future.delayed(Duration(seconds: 2)); // Simulate delay

    // Replace with actual HTTP request
    /*
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update teacher: ${response.statusCode}')),
      );
    }
    */

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Teacher updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Teacher'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Show teacher list dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select or Edit Teacher'),
                            content: Container(
                              width: double.minPositive,
                              child: ListView.builder(
                                itemCount: teacherList.length,
                                itemBuilder: (context, index) {
                                  final teacherName = teacherList[index];
                                  return ListTile(
                                    title: Text(teacherName),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        editTeacherName(index);
                                      },
                                    ),
                                    onTap: () {
                                      selectTeacher(teacherName);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('New Subjects'),
              DropdownSearch<int>.multiSelection(
                items: [101, 102, 103, 104, 105], // Example subject IDs
                dropdownBuilder: (context, selectedItems) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: selectedItems.map((item) => Chip(label: Text('$item'))).toList(),
                  );
                },
                popupProps: PopupPropsMultiSelection.menu(
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text('$item'),
                      selected: isSelected,
                    );
                  },
                ),
                onChanged: (List<int> value) {
                  setState(() {
                    _newSubjectIds = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('Remove Subjects'),
              DropdownSearch<int>.multiSelection(
                items: [201, 202, 203, 204, 205], // Example subject IDs
                dropdownBuilder: (context, selectedItems) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: selectedItems.map((item) => Chip(label: Text('$item'))).toList(),
                  );
                },
                popupProps: PopupPropsMultiSelection.menu(
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text('$item'),
                      selected: isSelected,
                    );
                  },
                ),
                onChanged: (List<int> value) {
                  setState(() {
                    _removeSubjectIds = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateTeacher();
                  }
                },
                child: Text('Update Teacher'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}























