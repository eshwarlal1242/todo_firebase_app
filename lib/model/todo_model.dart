import 'package:flutter/material.dart';

import '../screens/create_account.dart';
import '../screens/services/auth_service.dart';
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationWrapper(),
    );
  }
}