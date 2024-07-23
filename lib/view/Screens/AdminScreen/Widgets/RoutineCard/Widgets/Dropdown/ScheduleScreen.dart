// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../../model/RoutineModel/ClassSheduleModel.dart';
// import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/RoutineScreenController.dart';
//
// class ScheduleScreen extends StatelessWidget {
//   final ScheduleController scheduleController = Get.put(ScheduleController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.blue,
//         title: const Center(
//           child: Text(
//             'Routine Schedule',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (scheduleController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (scheduleController.schedule.isEmpty) {
//           return const Center(child: Text('No data available'));
//         } else {
//           return ListView.builder(
//             itemCount: scheduleController.schedule.keys.length,
//             itemBuilder: (ctx, index) {
//               String day = scheduleController.schedule.keys.elementAt(index);
//               List<Schedule> daySchedule = scheduleController.schedule[day]!;
//
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 45),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(10),
//                       color: Colors.blue,
//                       child: Text(
//                         day,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                           childAspectRatio: 1.3, // Adjust this ratio as needed
//                         ),
//                         itemCount: daySchedule.length,
//                         itemBuilder: (ctx, index) {
//                           Schedule schedule = daySchedule[index];
//                           return Card(
//                             margin: EdgeInsets.zero,
//                             child: Stack(
//                               children: [
//                                 SingleChildScrollView(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           schedule.subName,
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Text('Room: ${schedule.roomName}'),
//                                         Text('Teacher: ${schedule.teacherName}'),
//                                         Text('Paper Code: ${schedule.paperCode}'),
//                                         Text('Time: ${schedule.startingTime} - ${schedule.endingTime}'),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   right: 0,
//                                   child: IconButton(
//                                     icon: Icon(Icons.edit, color: Colors.blue),
//                                     onPressed: () {
//
//
//
//
//                                       // Print details of the selected schedule
//                                       print('Editing Schedule:');
//                                       print('teacherId: ${schedule.teacherId}');
//                                       print('subjectId: ${schedule.subjectId}');
//                                       print('day: ${schedule.day}');
//                                       print('startingTime: ${schedule.startingTime}');
//                                       print('endingTime: ${schedule.endingTime}');
//                                       print('roomName: ${schedule.roomName}');
//                                       print('id: ${schedule.id}');
//
//
//                                       _showEditDialog(context,  day,schedule);
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
//
//   void _showEditDialog(BuildContext context, String day, Schedule schedule) {
//     TextEditingController subNameController = TextEditingController(text: schedule.subName);
//     TextEditingController roomNameController = TextEditingController(text: schedule.roomName);
//     TextEditingController teacherNameController = TextEditingController(text: schedule.teacherName);
//     TextEditingController paperCodeController = TextEditingController(text: schedule.paperCode);
//     TextEditingController startingTimeController = TextEditingController(text: schedule.startingTime);
//     TextEditingController endingTimeController = TextEditingController(text: schedule.endingTime);
//     TextEditingController dayController = TextEditingController(text: day); // New TextEditingController for day
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Schedule'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: dayController,
//                   decoration: InputDecoration(labelText: 'Day'),
//                   enabled: false, // Make it uneditable
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: subNameController,
//                   decoration: InputDecoration(labelText: 'Subject Name'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: roomNameController,
//                   decoration: InputDecoration(labelText: 'Room Name'),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: teacherNameController,
//                   decoration: InputDecoration(labelText: 'Teacher Name'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: paperCodeController,
//                   decoration: InputDecoration(labelText: 'Paper Code'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: startingTimeController,
//                   decoration: InputDecoration(labelText: 'Starting Time'),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: endingTimeController,
//                   decoration: InputDecoration(labelText: 'Ending Time'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 schedule.roomName = roomNameController.text;
//                 schedule.startingTime = startingTimeController.text;
//                 schedule.endingTime = endingTimeController.text;
//                 // Update additional fields here
//               schedule.day=schedule.day;
//                 schedule.teacherId = schedule.teacherId; // Assuming teacherId is not editable
//                 schedule.subjectId = schedule.subjectId; // Assuming subjectId is not editable
//                 schedule.id = schedule.id; // Assuming id is not editable
//                 // Print values for debugging
//                 print('Updating Schedule:');
//                 print('teacherId: ${schedule.teacherId}');
//                 print('subjectId: ${schedule.subjectId}');
//                 print('day: ${schedule.day}');
//                 print('startingTime: ${schedule.startingTime}');
//                 print('endingTime: ${schedule.endingTime}');
//                 print('roomName: ${schedule.roomName}');
//                 print('id: ${schedule.id}');
//
//
//                 try {
//                   await scheduleController.updateSchedule(  day,schedule );
//                   Navigator.of(context).pop();
//                 } catch (error) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Failed to update schedule')),
//                   );
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../../model/RoutineModel/ClassSheduleModel.dart';
// import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/RoutineScreenController.dart';
//
//
// class ScheduleScreen extends StatelessWidget {
//   final ScheduleController scheduleController = Get.put(ScheduleController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.blue,
//         title: const Center(
//           child: Text(
//             'Routine Schedule',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         if (scheduleController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (scheduleController.schedule.isEmpty) {
//           return const Center(child: Text('No data available'));
//         } else {
//           return ListView.builder(
//             itemCount: scheduleController.schedule.keys.length,
//             itemBuilder: (ctx, index) {
//               String day = scheduleController.schedule.keys.elementAt(index);
//               List<Schedule> daySchedule = scheduleController.schedule[day]!;
//
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 45),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(10),
//                       color: Colors.blue,
//                       child: Text(
//                         day,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                           childAspectRatio: 1.3, // Adjust this ratio as needed
//                         ),
//                         itemCount: daySchedule.length,
//                         itemBuilder: (ctx, index) {
//                           Schedule schedule = daySchedule[index];
//                           return Card(
//                             margin: EdgeInsets.zero,
//                             child: Stack(
//                               children: [
//                                 SingleChildScrollView(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           schedule.subName,
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Text('Room: ${schedule.roomName}'),
//                                         Text('Teacher: ${schedule.teacherName}'),
//                                         Text('Paper Code: ${schedule.paperCode}'),
//                                         Text('Time: ${schedule.startingTime} - ${schedule.endingTime}'),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   right: 0,
//                                   child: PopupMenuButton<int>(
//                                     icon: Icon(Icons.more_vert, color: Colors.blue),
//                                     onSelected: (value) {
//                                       if (value == 0) {
//                                         _showEditDialog(context, day, schedule);
//                                       }
//                                     },
//                                     itemBuilder: (context) => [
//                                       PopupMenuItem(
//                                         value: 0,
//                                         child: Text('Edit'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
//
//   void _showEditDialog(BuildContext context, String day, Schedule schedule) {
//     TextEditingController subNameController = TextEditingController(text: schedule.subName);
//     TextEditingController roomNameController = TextEditingController(text: schedule.roomName);
//     TextEditingController teacherNameController = TextEditingController(text: schedule.teacherName);
//     TextEditingController paperCodeController = TextEditingController(text: schedule.paperCode);
//     TextEditingController startingTimeController = TextEditingController(text: schedule.startingTime);
//     TextEditingController endingTimeController = TextEditingController(text: schedule.endingTime);
//     TextEditingController dayController = TextEditingController(text: day);
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Schedule'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: dayController,
//                   decoration: InputDecoration(labelText: 'Day'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: subNameController,
//                   decoration: InputDecoration(labelText: 'Subject Name'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: roomNameController,
//                   decoration: InputDecoration(labelText: 'Room Name'),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: teacherNameController,
//                   decoration: InputDecoration(labelText: 'Teacher Name'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: paperCodeController,
//                   decoration: InputDecoration(labelText: 'Paper Code'),
//                   enabled: false,
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: startingTimeController,
//                   decoration: InputDecoration(labelText: 'Starting Time'),
//                 ),
//                 SizedBox(height: 20,),
//                 TextField(
//                   controller: endingTimeController,
//                   decoration: InputDecoration(labelText: 'Ending Time'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 schedule.roomName = roomNameController.text;
//                 schedule.startingTime = startingTimeController.text;
//                 schedule.endingTime = endingTimeController.text;
//                 schedule.day = schedule.day;
//                 schedule.teacherId = schedule.teacherId;
//                 schedule.subjectId = schedule.subjectId;
//                 schedule.id = schedule.id;
//
//                 try {
//                   await scheduleController.updateSchedule(day, schedule);
//                   Navigator.of(context).pop();
//                 } catch (error) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Failed to update schedule')),
//                   );
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
//
//
//
//









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
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 0) {
                // Handle menu action for the first option
                _showDeleteRoutineConfirmationDialog(context);
              }

            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text(' Delete Routine'),
              ),

            ],
          ),
        ],
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

              return Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (day == 'Monday')
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  day,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                PopupMenuButton<int>(
                                  icon: const Icon(Icons.more_vert, color: Colors.white),
                                  onSelected: (value) {
                                    if (value == 0) {
                                      // Handle menu action for Monday
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 0,
                                      child: Text('Edit Monday'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (day != 'Monday')
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
                                      child: PopupMenuButton<int>(
                                        icon: Icon(Icons.more_vert, color: Colors.blue),
                                        onSelected: (value) {
                                          if (value == 0) {
                                            _showEditDialog(context, day, schedule);
                                          } if (value == 1) {

                                            _showDeleteConfirmationDialog(context, day, schedule.id);

                                          }
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 0,
                                            child: Text('Edit'),
                                          ),
                                            const PopupMenuItem(
                                            value: 1,
                                            child: Text('Delete Class'),
                                          ),

                                        ],
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
                  ),
                ],
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
    TextEditingController dayController = TextEditingController(text: day);

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
                  enabled: false,
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
                schedule.day = schedule.day;
                schedule.teacherId = schedule.teacherId;
                schedule.subjectId = schedule.subjectId;
                schedule.id = schedule.id;

                try {
                  await scheduleController.updateSchedule(day, schedule);
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




  void _showDeleteConfirmationDialog(BuildContext context, String day, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Class'),
          content: Text('Are you sure you want to delete this class?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                scheduleController.deleteClass(day, id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }


  void _showDeleteRoutineConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Routine'),
          content: Text('Are you sure you want to delete this Routine?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                scheduleController.deleteRoutine();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }


}
