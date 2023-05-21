import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 25.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.red,
      child: const Icon(Icons.delete),
    );
  }
}

class SecondBackground extends StatelessWidget {
  const SecondBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 25.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.green,
      child: const Icon(Icons.golf_course),
    );
  }
}
