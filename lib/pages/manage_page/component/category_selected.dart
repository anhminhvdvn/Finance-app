import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectedCategory extends StatelessWidget {
  String title;
  SelectedCategory({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 50,
      child: Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent.shade200,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
