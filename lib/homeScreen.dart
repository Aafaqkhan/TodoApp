import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_todo/AuthService.dart';
import 'package:new_todo/databaseService.dart';
import 'package:new_todo/notificationService.dart';
import 'package:new_todo/signUp.dart';
import 'package:new_todo/tasks.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDiscController = TextEditingController();

  @override
  // void initState() {
  //   super.initState();
  //   readTaskData();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body:
          //  ListView(
          //   children: [
          Column(
        children: [
          TextField(
            controller: _taskNameController,
          ),
          TextField(
            controller: _taskDiscController,
          ),
          MaterialButton(
            onPressed: () async {
              final taskName = _taskNameController.text;
              final taskDisc = _taskDiscController.text;
              print('save start');
              NotificationService().scheduleNotification(taskName);
              await DatabaseService()
                  .addTask(widget.userId, taskName, taskDisc);
              _taskNameController.clear();
              _taskDiscController.clear();
              // FirebaseFirestore.instance
              //     .collection('tasks')
              //     .doc(widget.userId)
              //     .set(
              //   {
              //     'userId': widget.userId,
              //     'taskName': taskName,
              //     'taskDisc': taskDisc,
              //   },
              // ).then((value) {
              //   print('Task added successfully!');
              //   _taskNameController.clear();
              //   _taskDiscController.clear();
              // }).catchError((error) {
              //   print('Failed to add task: $error');
              // });
            },
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Tasks()),
              );
            },
            child: Text('Tasks'),
          ),
          MaterialButton(
            onPressed: () {
              AuthService().handleSignOut(context);
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
