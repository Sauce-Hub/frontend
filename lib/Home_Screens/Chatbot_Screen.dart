import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.smart_toy, size: 80, color: const Color.fromARGB(255, 229, 159, 27)),
            SizedBox(height: 20),
            Text("Chatbot Screen", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}