import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BackGroundWidget extends StatelessWidget {
  Widget child;
  BackGroundWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blueAccent, Colors.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
