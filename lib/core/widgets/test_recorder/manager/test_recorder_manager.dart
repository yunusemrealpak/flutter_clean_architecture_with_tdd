import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestRecorderManager extends StatefulWidget {
  final Widget child;
  final bool active;
  const TestRecorderManager(
      {super.key, required this.child, this.active = true});

  @override
  State<TestRecorderManager> createState() => _TestRecorderManagerState();
}

class _TestRecorderManagerState extends State<TestRecorderManager> {
  @override
  Widget build(BuildContext context) {
    if (!(kDebugMode && widget.active)) {
      return widget.child;
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            color: Colors.red,
            child: const Text('Recording'),
          ),
        ),
        widget.child,
      ],
    );
  }
}
