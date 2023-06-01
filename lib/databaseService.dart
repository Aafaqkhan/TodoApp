import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');
  DatabaseService();

  Future<void> addTask(String userId, String taskName, String taskDisc) async {
    tasksCollection.doc(userId).set(
      {
        'userId': userId,
        'taskName': taskName,
        'taskDisc': taskDisc,
      },
      SetOptions(merge: false),
    ).then((value) {
      print('Task added successfully!');
    }).catchError((error) {
      print('Failed to add task: $error');
    });
  }

  // Future<List<Map<String, dynamic>>> getTasksByUserId(String userId) async {
  //   try {
  //     QuerySnapshot querySnapshot = await tasksCollection
  //         .where('userId', isEqualTo: userId)
  //         .get();

  //     List<Map<String, dynamic>> tasks = querySnapshot.docs.map((document) {
  //       Map<String, dynamic> data = document.data();
  //       String taskId = document.id;
  //       String taskName = data['taskName'];
  //       String taskDisc = data['taskDisc'];

  //       return {
  //         'taskId': taskId,
  //         'taskName': taskName,
  //         'taskDisc': taskDisc,
  //       };
  //     }).toList();

  //     return tasks;
  //   } catch (e) {
  //     print('Error retrieving tasks: $e');
  //     return [];
  //   }
  // }

  Future<void> deleteTask(
    String taskId,
  ) async {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .delete()
        .then((value) {
      print('Document updated successfully!');
    }).catchError((error) {
      print('Failed to update document: $error');
    });
  }
}
