import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/todo_model.dart';

class DatabaseService {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');


  // Add a task for a specific user
  Future<String?> addTask({
    required String email,
    required String taskTitle,
    required String taskDescription,
  }) async {
    try {
      DocumentReference userDoc = usersCollection.doc(email);

      // Add a task to the user's 'tasks' subcollection
      await userDoc.collection('tasks').add({
        'title': taskTitle,
        'description': taskDescription,
        'created_at': FieldValue.serverTimestamp(),
      });
      return 'Task added successfully';
    } catch (e) {
      return 'Error adding task: $e';
    }
  }

  // Fetch all tasks for a specific user
  Future<List<Map<String, dynamic>>?> getTasks(String email) async {
    try {
      DocumentReference userDoc = usersCollection.doc(email);

      // Fetch all tasks from the 'tasks' subcollection
      QuerySnapshot tasksSnapshot = await userDoc.collection('tasks').get();

      List<Map<String, dynamic>> tasks = tasksSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'description': doc['description'],
          'created_at': doc['created_at'],
        };
      }).toList();

      return tasks;
    } catch (e) {
      return null; // Return null or handle the error appropriately
    }
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateTask({
    required String email,
    required String taskId,
    required String updatedTitle,
    required String updatedDescription,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(email)
          .collection('tasks')
          .doc(taskId)
          .update({
        'title': updatedTitle,
        'description': updatedDescription,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating task: $e');
      throw e;
    }
  }

  // Delete a specific task for a user
  Future<String?> deleteTask({
    required String email,
    required String taskId,
  }) async {
    try {
      DocumentReference userDoc = usersCollection.doc(email);

      // Delete the task from the 'tasks' subcollection
      await userDoc.collection('tasks').doc(taskId).delete();
      return 'Task deleted successfully';
    } catch (e) {
      return 'Error deleting task: $e';
    }
  }
}






