import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/update/TeacherUpdateController.dart';

class TeacherUpdateScreen extends StatelessWidget {
  final TeacherUpdateController controller = Get.put(TeacherUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Teacher'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.nameController,
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
                            child: Obx(() => ListView.builder(
                              itemCount: controller.teacherList.length,
                              itemBuilder: (context, index) {
                                final teacherName = controller.teacherList[index];
                                return ListTile(
                                  title: Text(teacherName),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      controller.editTeacherName(index, 'New Name');
                                    },
                                  ),
                                  onTap: () {
                                    controller.selectTeacher(teacherName);
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            )),
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
            // DropdownSearch for new subjects (code remains similar)

            SizedBox(height: 20),
            Text('Remove Subjects'),
            // DropdownSearch for remove subjects (code remains similar)

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.nameController.text.isNotEmpty) {
                  controller.updateTeacher();
                } else {
                  Get.snackbar('Error', 'Please enter the name');
                }
              },
              child: Text('Update Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
