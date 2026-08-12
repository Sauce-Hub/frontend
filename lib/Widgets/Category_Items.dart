import 'package:flutter/material.dart';

Widget categoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF97316),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }