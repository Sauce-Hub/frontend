import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

//BottomBarItems
BottomBarItem bottomBarItem({
  required IconData icon,
  required String text,
}) => BottomBarItem(
  inActiveItem: Icon( icon, color: Colors.black),
  activeItem: Icon(icon, color: Color(0xFFF97316)),
  itemLabel: text,
);



