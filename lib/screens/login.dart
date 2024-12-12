import 'package:flutter/material.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eshwar"),
      ),
      body:Padding(
          padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Eshwar"),
          const SizedBox(height: 20),
          Text("Eshwar"),

        ],

      ),) ,
    );
  }
}
