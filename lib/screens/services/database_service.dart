import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_firebase_app/model/todo_model.dart';

class DatabaseService {
  
  final CollectionReference
  todoCollection = FirebaseFirestore.instance.collection("todo");

  User? user = FirebaseAuth.instance.currentUser;
// add todo Task
  Future<DocumentReference> addTodoTask(String title,String description) async {
    return await todoCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createAt':FieldValue.serverTimestamp(),

    }
        );

  }

  Future<void> updateTodo(String id ,String title, String description) async {

    final updatetodoCollection = FirebaseFirestore.instance.collection("todo").doc(id);

    return await updatetodoCollection.update({
      'title': title,
      'description':description
    });
  }


  Future<void> updatetodoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({'completed':completed});
  }

  Future<void> deleteTodoTask(String id) async {
    return await todoCollection.doc(id).delete();
  }

  Stream<List<Todo>> get todos {
    return todoCollection.where('uid',isEqualTo: user!.uid).where('completed',isEqualTo: false).snapshots().map(_todoListFromSnapshot);

  }
  Stream<List<Todo>> get completedtodos {
    return todoCollection.where('uid',isEqualTo: user!.uid).where('completed',isEqualTo: true).snapshots().map(_todoListFromSnapshot);

  }

  List<Todo> _todoListFromSnapshot(QuerySnapshot snap) {
    return snap.docs.map((doc) {
      return Todo(
          id:doc.id,
          title:doc['title'] ?? '',
          description:doc['description'] ?? '',
          completed:doc['completed'] ?? false,
          timeStamp:doc['creatAt']?? '');


    }).toList();
  }


}

