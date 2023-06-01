import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_todo/databaseService.dart';
import 'package:new_todo/taskWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  late String userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserId = prefs.getString('userId');

    if (savedUserId != null) {
      setState(() {
        userId = savedUserId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .where('userId', isEqualTo: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return Text('No data available');
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                String taskId = document.id;
                String taskName = data['taskName'];
                String taskDisc = data['taskDisc'];
                return TaskWidget(
                    userId: userId,
                    taskId: taskId,
                    taskName: taskName,
                    taskDisc: taskDisc,
                    onDelete: () {
                      DatabaseService().deleteTask(taskId);
                    });
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
