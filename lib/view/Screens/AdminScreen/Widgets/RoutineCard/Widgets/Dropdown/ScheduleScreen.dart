import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../model/RoutineModel/ClassSheduleModel.dart';
import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/RoutineScreenController.dart';

class ScheduleScreen extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Routine Schedule',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Obx(() {
        if (scheduleController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (scheduleController.schedule.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return ListView.builder(
            itemCount: scheduleController.schedule.keys.length,
            itemBuilder: (ctx, index) {
              String day = scheduleController.schedule.keys.elementAt(index);
              List<Schedule> daySchedule = scheduleController.schedule[day]!;

              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 45),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.3, // Adjust this ratio as needed
                        ),
                        itemCount: daySchedule.length,
                        itemBuilder: (ctx, index) {
                          Schedule schedule = daySchedule[index];
                          return Card(
                            margin: EdgeInsets.zero,
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          schedule.subName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text('Room: ${schedule.roomName}'),
                                        Text('Teacher: ${schedule.teacherName}'),
                                        Text('Paper Code: ${schedule.paperCode}'),
                                        Text('Time: ${schedule.startingTime} - ${schedule.endingTime}'),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {




                                      // Print details of the selected schedule
                                      print('Editing Schedule:');
                                      print('teacherId: ${schedule.teacherId}');
                                      print('subjectId: ${schedule.subjectId}');
                                      print('day: ${schedule.day}');
                                      print('startingTime: ${schedule.startingTime}');
                                      print('endingTime: ${schedule.endingTime}');
                                      print('roomName: ${schedule.roomName}');
                                      print('id: ${schedule.id}');


                                      _showEditDialog(context,  day,schedule);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showEditDialog(BuildContext context, String day, Schedule schedule) {
    TextEditingController subNameController = TextEditingController(text: schedule.subName);
    TextEditingController roomNameController = TextEditingController(text: schedule.roomName);
    TextEditingController teacherNameController = TextEditingController(text: schedule.teacherName);
    TextEditingController paperCodeController = TextEditingController(text: schedule.paperCode);
    TextEditingController startingTimeController = TextEditingController(text: schedule.startingTime);
    TextEditingController endingTimeController = TextEditingController(text: schedule.endingTime);
    TextEditingController dayController = TextEditingController(text: day); // New TextEditingController for day

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Schedule'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: dayController,
                  decoration: InputDecoration(labelText: 'Day'),
                  enabled: false, // Make it uneditable
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: subNameController,
                  decoration: InputDecoration(labelText: 'Subject Name'),
                  enabled: false,
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: roomNameController,
                  decoration: InputDecoration(labelText: 'Room Name'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: teacherNameController,
                  decoration: InputDecoration(labelText: 'Teacher Name'),
                  enabled: false,
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: paperCodeController,
                  decoration: InputDecoration(labelText: 'Paper Code'),
                  enabled: false,
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: startingTimeController,
                  decoration: InputDecoration(labelText: 'Starting Time'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: endingTimeController,
                  decoration: InputDecoration(labelText: 'Ending Time'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                schedule.roomName = roomNameController.text;
                schedule.startingTime = startingTimeController.text;
                schedule.endingTime = endingTimeController.text;
                // Update additional fields here
              schedule.day=schedule.day;
                schedule.teacherId = schedule.teacherId; // Assuming teacherId is not editable
                schedule.subjectId = schedule.subjectId; // Assuming subjectId is not editable
                schedule.id = schedule.id; // Assuming id is not editable
                // Print values for debugging
                print('Updating Schedule:');
                print('teacherId: ${schedule.teacherId}');
                print('subjectId: ${schedule.subjectId}');
                print('day: ${schedule.day}');
                print('startingTime: ${schedule.startingTime}');
                print('endingTime: ${schedule.endingTime}');
                print('roomName: ${schedule.roomName}');
                print('id: ${schedule.id}');


                try {
                  await scheduleController.updateSchedule(  day,schedule );
                  Navigator.of(context).pop();
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update schedule')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
