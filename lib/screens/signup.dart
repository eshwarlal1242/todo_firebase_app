import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_app/screens/login.dart';
import 'package:todo_firebase_app/screens/services/auth_service.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }

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
              Text(
                "Register here",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white60),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white60),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _signup,
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.indigo, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'OR',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.indigo, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
