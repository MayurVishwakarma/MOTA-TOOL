import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "No Data Found",
      style: TextStyle(color: Colors.white),
    );
  }
}
