import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_app/screens/login.dart';
import 'package:todo_firebase_app/screens/services/auth_service.dart';
import 'package:todo_firebase_app/screens/signup.dart';

import 'model/todo_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCQrScrUdU28azfcrQZrVjulemuCr1-sKI",
            appId: "1:1030494534:web:17e3b9ebfd47195baead47",
            messagingSenderId: "1030494534",
            projectId: "to-do-firebase-e429e"));
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginPage(),
    );
  }
}

