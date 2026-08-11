import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

BottomBarItem bottomBarItem({required IconData icon, required String text}) =>
    BottomBarItem(
      inActiveItem: Icon(icon, color: Color(0xFFF97316)),
      activeItem: Icon(icon, color: Colors.black),
      itemLabelWidget: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
