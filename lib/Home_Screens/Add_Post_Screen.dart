import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 80, color: const Color.fromARGB(255, 229, 159, 27)),
            SizedBox(height: 20),
            Text("add post", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}