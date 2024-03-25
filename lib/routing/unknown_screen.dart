import 'package:flutter/material.dart';

/// Unknown screen for debugging purposes
///
/// Author: Shreif Abdalla
class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('That was not supposed to happen!'),
      ),
    );
  }
}
