import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.comment, size: 80, color: const Color.fromARGB(255, 229, 159, 27)),
            SizedBox(height: 20),
            Text("comments", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}