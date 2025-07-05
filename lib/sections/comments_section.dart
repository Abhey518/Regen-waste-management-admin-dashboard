import 'package:flutter/material.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Text(
          'Comments Management\n(Mock Content)',
          style: TextStyle(fontSize: 24, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
