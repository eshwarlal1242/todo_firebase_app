import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase_app/screens/services/database_service.dart';

class TodoPage extends StatefulWidget {
  final String userEmail;

  TodoPage({required this.userEmail});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final DatabaseService databaseService = DatabaseService();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  List<Map<String, dynamic>> tasks = [];
  String? _editingTaskId;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final fetchedTasks = await databaseService.getTasks(widget.userEmail);
    if (fetchedTasks != null) {
      setState(() {
        tasks = fetchedTasks;
      });
    }
  }

  Future<void> _addOrUpdateTask() async {
    final title = _taskTitleController.text.trim();
    final description = _taskDescriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      if (_editingTaskId == null) {
        await databaseService.addTask(
          email: widget.userEmail,
          taskTitle: title,
          taskDescription: description,
        );
      } else {
        await databaseService.updateTask(
          email: widget.userEmail,
          taskId: _editingTaskId!,
          updatedTitle: title,
          updatedDescription: description,
        );
        _editingTaskId = null;
      }
      _taskTitleController.clear();
      _taskDescriptionController.clear();
      _fetchTasks();
    }
  }

  Future<void> _deleteTask(String taskId) async {
    await databaseService.deleteTask(email: widget.userEmail, taskId: taskId);
    _fetchTasks();
  }

  void _startEditingTask(Map<String, dynamic> task) {
    setState(() {
      _editingTaskId = task['id'];
      _taskTitleController.text = task['title'];
      _taskDescriptionController.text = task['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        title: Text('To-Do App', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskTitleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    labelStyle: TextStyle(color: Colors.white60),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _taskDescriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Task Description',
                    labelStyle: TextStyle(color: Colors.white60),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white60),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addOrUpdateTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _editingTaskId == null ? 'Add Task' : 'Update Task',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final createdAt = task['created_at'] != null
                    ? DateFormat('dd MMM yyyy, hh:mm a').format((task['created_at'] as Timestamp).toDate())
                    : 'N/A';
                return Card(
                  color: Color(0xFF2a2f3a),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(task['title'], style: TextStyle(color: Colors.white)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task['description'], style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 5),
                        Text('Added on: $createdAt', style: TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _startEditingTask(task),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(task['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
