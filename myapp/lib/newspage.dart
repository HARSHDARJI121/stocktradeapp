import 'package:flutter/material.dart';


class Newspage extends StatelessWidget {
  const Newspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: const Color(0xFF1f4037),
      ),
      body: const Center(
        child: Text(
          'Latest news will appear here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}