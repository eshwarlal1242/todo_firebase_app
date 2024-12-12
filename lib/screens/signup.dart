import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_app/screens/services/auth_service.dart';
class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text("Register here",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),

            ),
            const SizedBox(
              height: 30,
            ),

            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.white60
                )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                      color: Colors.white60
                  )
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  User? user = await _auth.RegisterWithEmailAndPassword(
                      _emailController.text,
                      _passController.text );
                  if(user != null) {
                    Navigator.push(context, MaterialPageRoute(builder: builder))
                  }
                  

            }, child: child)
          ],
        )
          ,),


      ),
    );
  }
}
