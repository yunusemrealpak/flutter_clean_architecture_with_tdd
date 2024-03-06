import 'package:flutter/material.dart';

class GestureWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const GestureWrapper({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: child,
    );
  }
}
