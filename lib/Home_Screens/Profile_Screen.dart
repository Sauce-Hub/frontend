import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: const Color.fromARGB(255, 229, 159, 27)),
            SizedBox(height: 20),
            Text("Profile Screen", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}