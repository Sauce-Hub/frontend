import 'package:flutter/material.dart';

Widget getSlideUpWidget({required Widget child}) {
  return TweenAnimationBuilder<Offset>(
    tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
    builder: (context, offset, childWidget) {
      return FractionalTranslation(
        translation: offset,
        child: childWidget,
      );
    },
    child: child,
  );
}