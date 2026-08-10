import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: const Color.fromARGB(255, 229, 159, 27)),
            SizedBox(height: 20),
            Text("For you Screen", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}