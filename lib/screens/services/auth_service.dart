import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class AuthService {
   final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<User?> signInWithEmailAndPassword(String email,String password) async {
     try {
       UserCredential result = await _auth.signInWithEmailAndPassword(
           email: email, password: password);

       User? user = result.user;
       return user;
     }
     catch(e) {
       print(e.toString());
       return null;
     }
   }
   Future<User?> RegisterWithEmailAndPassword(String email,String password) async {
     try {
       UserCredential result = await _auth.createUserWithEmailAndPassword(
           email: email, password: password);

       User? user = result.user;
       return user;
     }
     catch(e) {
       print(e.toString());
       return null;
     }
   }
   Future<void> SignOut() async{
     try {
       return await _auth.signOut();
     }
     catch(e) {
       print(e.toString());
       return null;
     }
   }
}