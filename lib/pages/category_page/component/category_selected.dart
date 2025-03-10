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
            color: Color.fromARGB(255, 6, 47, 192),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
