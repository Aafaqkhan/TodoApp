import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.userId,
    required this.taskId,
    required this.taskName,
    required this.taskDisc,
    required this.onDelete,
  }) : super(key: key);

  final String userId;
  final String taskId;
  final String taskName;
  final String taskDisc;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 15.0),
      child: ListTile(
        leading: Text(userId),
        title: Text(taskName),
        subtitle: Text(taskDisc),
        isThreeLine: true,
        trailing: PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: const Text('Delete'),
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
